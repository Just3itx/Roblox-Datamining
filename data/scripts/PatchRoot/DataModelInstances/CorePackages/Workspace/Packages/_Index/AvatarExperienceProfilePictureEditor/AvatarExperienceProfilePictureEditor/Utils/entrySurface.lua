-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:50:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditorParent = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor").Parent
local AvatarScreen = require(AvatarExperienceProfilePictureEditorParent.AvatarExperienceNavigation).Enums.AvatarScreen

return {
    resolve = function(tbl1)
        if not tbl1.getParam then
            return nil, nil
        end

        local param = tbl1.getParam("entryOrigin")
        if param and param.screenName then
            return param.screenName, param.screenParams
        end

        return tbl1.getParam("prevNavPage"), nil
    end,
    park = function(tbl1, avatarExperienceLandingPage: string?)
        if tbl1.navigate == nil then
            return
        end
        tbl1.navigate(
            if avatarExperienceLandingPage == AvatarScreen.AvatarExperienceLandingPage then AvatarScreen.AvatarExperienceLandingPage else AvatarScreen.Catalog
        )
    end
}
