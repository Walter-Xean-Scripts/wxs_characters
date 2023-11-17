local Callbacks = WXSCore.Callbacks
---@type Foact
local Foact = WXSCore.Foact

local UI = Foact.new(GetCurrentResourceName() .. "_charselectui")
local UI2 = Foact.new(GetCurrentResourceName() .. "_charcreateui")
local charsElements = {}

local SelectUI = require 'uis.selectui'
SelectUI:Init(UI, UI2)

local function startCharacterSelection()
    local characters = Callbacks.Await("WXS:Server:GetCharacters")
    if characters then
        SelectUI:ClearCharacters(charsElements)
        for _, char in ipairs(characters) do
            local charElement = UI:createElement("Button", {
                text = char.firstName .. " " .. char.lastName,
                onClick = function()
                    Callbacks("WXS:Server:SelectCharacter", false, char.id)
                end
            })

            table.insert(charsElements, charElement)
            SelectUI:AddChild(charElement)
        end

        UI:SetActive(true, true)
    end
end

local CreateUI = require 'uis.createui'
CreateUI:Init(UI, UI2, startCharacterSelection)

-- Start loop
CreateThread(function()
    while true do
        while not NetworkIsSessionStarted() do
            Wait(500)
        end

        startCharacterSelection()
        break
    end
end)

RegisterNetEvent("WXS:Client:CharacterLoaded", function(characterData)
    if characterData.metadata.lastCoords then
        local coords = characterData.metadata.lastCoords
        SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z, true, false, false, false)
        SetEntityHeading(PlayerPedId(), characterData.metadata.lastHeading or 0.0)
    end

    UI:SetActive(false, false)
end)
