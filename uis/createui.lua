local Callbacks = WXSCore.Callbacks
local CreateUI = {}

function CreateUI:Init(UI, UI2, showChars)
    local firstNameValue = ""
    local firstName = UI2:createElement("Input", {
        placeholder = "First name...",
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
        placeholder = "Last name...",
        width = "100%",
        type = "Input",
        marginTop = "10px",
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
        marginTop = "10px",
        onChange = function(id, name, event)
            local target = event.target
            local checked = target.checked
            genderValue = checked and 2 or 1
        end,
    })

    local createButton = UI2:createElement("Button", {
        text = "Create",
        marginBottom = "30px",
        type = "primary",
        onClick = function()
            if firstNameValue ~= "" and lastNameValue ~= "" then
                Callbacks("WXS:Server:CreateCharacter", function(success)
                    if success then
                        print("Character created!")
                        showChars()
                    else
                        print("Character creation failed!")
                    end
                end, firstNameValue, lastNameValue, genderValue)
                UI2:SetActive(false, false)
            end
        end
    })

    local logo = UI:createElement("Image", {
        src = "wxframework.png",
        width = "80%",
        height = "auto",
    })

    local inputBox = UI:createElement("Box", {
        width = "50%",
        display = "flex",
        flexDirection = "column",
        alignItems = "center",
        justifyContent = "center",
        marginBottom = "20px",
    }, {
        firstName,
        lastName,
        gender,
    })

    local parent2 = UI2:createElement("Box", {
        position = "absolute",
        top = "50%",
        left = "50%",
        transform = "translate(-50%, -50%)",
        width = "800px",
        backgroundColor = "rgba(30, 30, 30, 0.98)",
        borderRadius = "10px",
        display = "flex",
        flexDirection = "column",
        alignItems = "center",
        justifyContent = "center",
    }, {
        logo,
        inputBox,
        createButton
    })

    UI2:initialize(parent2)
end

return CreateUI
