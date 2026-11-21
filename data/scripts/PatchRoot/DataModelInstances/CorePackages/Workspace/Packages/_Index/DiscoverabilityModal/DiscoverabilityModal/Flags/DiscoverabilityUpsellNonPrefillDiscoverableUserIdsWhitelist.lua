-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:20:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastString("DiscoverabilityUpsellNonPrefillDiscoverableUserIdsWhitelist", "")

return {
    isWhitelistedUserId = function(arg1)
        local fastString = game:GetFastString("DiscoverabilityUpsellNonPrefillDiscoverableUserIdsWhitelist")
        for value in string.gmatch(fastString, "[^,]+") do
            if tostring(arg1) == value then
                return true
            end
        end
        return false
    end
}
