-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:10:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfile = script:FindFirstAncestor("EditProfile")
local EditProfileParent = EditProfile.Parent

local React = require(EditProfileParent.React)

local getAppStorageService = require(EditProfile.Common.getAppStorageService)

local function useProfileFramesNewLabel()
    local appStorageService = getAppStorageService()
    local var1, var2 = React.useState(function(): boolean
        local success, result = pcall(function()
            return appStorageService:GetItem("ProfileFramesNewLabelSeen")
        end)

        return success and result ~= "true"
    end)

    return var1, (React.useCallback(function()
        var2(false)
        pcall(function()
            appStorageService:SetItem("ProfileFramesNewLabelSeen", "true")
            appStorageService:Flush()
        end)
    end, { appStorageService }))
end

return useProfileFramesNewLabel
