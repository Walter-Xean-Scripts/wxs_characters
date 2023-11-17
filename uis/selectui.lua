local SelectUI = {}
local parent = nil

function SelectUI:Init(UI, UI2)
    local newCharButton = UI:createElement("Button", {
        text = "Create new character",
        icon = "PlusOutlined",
        type = "primary",
        marginBottom = "30px",
        onClick = function()
            UI:SetActive(false, false)
            Wait(100)
            UI2:SetActive(true, true)
        end
    })

    local logo = UI:createElement("Image", {
        src = "wxframework.png",
        width = "80%",
        height = "auto",
    })

    local text = UI:createElement("Text", {
        text = "Select a character:",
        fontSize = "25px",
        color = "white",
        fontWeight = "bold",
        marginBottom = "20px",
    })

    parent = UI:createElement("Box", {
        display = "flex",
        flexDirection = "row",
        gap = "20px",
    })

    local divider = UI:createElement("Divider", {})
    local divider2 = UI:createElement("Divider", {})

    local container = UI:createElement("Box", {
        position = "absolute",
        width = "800px",
        backgroundColor = "rgba(30, 30, 30, 0.98)",
        top = "50%",
        left = "50%",
        transform = "translate(-50%, -50%)",
        borderRadius = "10px",
        display = "flex",
        flexDirection = "column",
        alignItems = "center",
        justifyContent = "center",
    }, {
        logo,
        divider,
        text,
        parent,
        divider2,
        newCharButton
    })

    local screen = UI:createElement("Box", {
        position = "absolute",
        width = "100%",
        height = "100%",
        top = "0px",
        left = "0px",
    }, {
        container
    })

    UI:initialize(screen)
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
