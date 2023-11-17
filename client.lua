local Callbacks = WXSCore.Callbacks
---@type Foact
local Foact = WXSCore.Foact

local UI = Foact.new(GetCurrentResourceName() .. "_charselectui")
local UI2 = Foact.new(GetCurrentResourceName() .. "_charcreateui")

local newCharButton = UI:createElement("Button", {
    text = "Create new character",
    onClick = function()
        UI:SetActive(false, false)
        Wait(100)
        UI2:SetActive(true, true)
    end
})

local charsElements = {}
local parent = UI:createElement("Box", {
    position = "absolute",
    width = "300px",
    height = "500px",
    backgroundColor = "rgba(0, 0, 0, 0.5)",
    top = "50%",
    right = "0px",
    transform = "translateY(-50%)",
    display = "flex",
    flexDirection = "column",
    alignItems = "center",
    justifyContent = "center",
}, {
    newCharButton
})

UI:initialize(parent)

local function startCharacterSelection()
    local characters = Callbacks.Await("WXS:Server:GetCharacters")
    if characters then
        for k, v in ipairs(charsElements) do
            parent:remove(v)
        end

        for _, char in ipairs(characters) do
            local charElement = UI:createElement("Button", {
                text = char.firstName .. " " .. char.lastName,
                onClick = function()
                    Callbacks("WXS:Server:SelectCharacter", false, char.id)
                end
            })

            table.insert(charsElements, charElement)
            parent:add(charElement)
        end

        UI:SetActive(true, true)
    end
end

local firstNameValue = ""
local firstName = UI2:createElement("Input", {
    placeholder = "Input Here...",
    width = "100%",
    type = "Input",
    -- Fired when user changes input textfield
    onChange = function(id, name, event)
        local value = event.target.value
        firstNameValue = value
    end
})

local lastNameValue = ""
local lastName = UI2:createElement("Input", {
    placeholder = "Input Here...",
    width = "100%",
    type = "Input",
    -- Fired when user changes input textfield
    onChange = function(id, name, event)
        local value = event.target.value
        lastNameValue = value
    end
})

local genderValue = 1
local gender = UI2:createElement("Checkbox", {
    text = "Is Female?",
    defaultChecked = false,
    onChange = function(id, name, event)
        local target = event.target
        local checked = target.checked
        genderValue = checked and 2 or 1
    end,
})

local createButton = UI2:createElement("Button", {
    text = "Create",
    onClick = function()
        if firstNameValue ~= "" and lastNameValue ~= "" then
            Callbacks("WXS:Server:CreateCharacter", function(success)
                if success then
                    print("Character created!")
                    startCharacterSelection()
                else
                    print("Character creation failed!")
                end
            end, firstNameValue, lastNameValue, genderValue)
            UI2:SetActive(false, false)
        end
    end
})

local parent2 = UI2:createElement("Box", {
    position = "absolute",
    width = "300px",
    height = "300px",
    backgroundColor = "rgba(0, 0, 0, 0.8)",
    display = "flex",
    flexDirection = "column",
    alignItems = "center",
    justifyContent = "center",
}, {
    firstName,
    lastName,
    gender,
    createButton
})

UI2:initialize(parent2)

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
