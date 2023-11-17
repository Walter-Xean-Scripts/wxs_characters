local SelectUI = {}
local parent = nil

function SelectUI:Init(UI, UI2)
    local newCharButton = UI:createElement("Button", {
        text = "Create new character",
        onClick = function()
            UI:SetActive(false, false)
            Wait(100)
            UI2:SetActive(true, true)
        end
    })


    parent = UI:createElement("Box", {
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
end

function SelectUI:ClearCharacters(charsElements)
    if not parent then return end

    for _, v in ipairs(charsElements) do
        parent:remove(v)
    end
end

function SelectUI:AddChild(child)
    if not parent then return end

    parent:add(child)
end

return SelectUI
