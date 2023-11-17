local Callbacks = WXSCore.Callbacks
local CreateUI = {}

function CreateUI:Init(UI, UI2, showChars)
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
                        showChars()
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
end

return CreateUI
