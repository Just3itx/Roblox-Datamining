-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:11:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MESSAGES = {
    imageInReview = "The generated image is still under review.",
    imagePreparing = "The generated image is still being prepared.",
    imageTooLarge = "The generated image exceeds the 5 MB limit.",
    imageTimedOut = "The generated image could not be downloaded in time.",
    imageFailed = "The generated image could not be downloaded.",
    moderated = "Roblox moderation altered this product's text.",
    noUniverse = "No universe is associated with this session."
}

return {
    MESSAGES = MESSAGES,
    classify = function(str1: string?)
        if str1 == nil then
            return nil
        end
        for value, value2 in MESSAGES do
            if string.find(str1, value2, 1, true) ~= nil then
                return value
            end
        end
        return nil
    end
}
