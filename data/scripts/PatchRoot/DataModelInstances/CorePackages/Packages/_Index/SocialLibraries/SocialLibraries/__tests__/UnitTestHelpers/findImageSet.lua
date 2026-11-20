-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:31:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLibraries = script:FindFirstAncestor("SocialLibraries")
local UIBlox = require(SocialLibraries.dependencies).UIBlox

return function(arg1)
    local var1 = UIBlox.App.ImageSet.Images[arg1]

    return {
        Image = var1.Image,
        ImageRectSize = var1.ImageRectSize,
        ImageRectOffset = var1.ImageRectOffset
    }
end
