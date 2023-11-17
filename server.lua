local Callbacks = WXSCore.Callbacks

Callbacks.Register("WXS:Server:GetCharacters", function(source)
    local player = Framework.Player:Get(source)

    if player then
        local characters = player:GetCharacters()
        return characters
    end

    return nil
end)

Callbacks.Register("WXS:Server:CreateCharacter", function(source, firstNameValue, lastNameValue, genderValue)
    local player = Framework.Player:Get(source)

    local success = player:CreateCharacter({
        firstName = firstNameValue,
        lastName = lastNameValue,
        dateOfBirth = "NA/NA/NANA",
        height = 190,
        gender = genderValue
    })

    return success
end)

Callbacks.Register("WXS:Server:SelectCharacter", function(source, characterId)
    local player = Framework.Player:Get(source)

    if player then
        local success = player:LoadCharacter(characterId)
        return success
    end

    return false
end)
