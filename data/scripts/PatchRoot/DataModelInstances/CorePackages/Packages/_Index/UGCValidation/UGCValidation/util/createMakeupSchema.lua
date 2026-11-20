-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:20:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function createMakeupSchema()
    return {
        ClassName = "Decal",
        _children = {
            {
                Name = "ThumbnailConfiguration",
                ClassName = "Configuration",
                _optional = true,
                _children = {{ Name = "SkinColorValue", ClassName = "Color3Value" }}
            },
            { Name = "WrapTextureTransfer", ClassName = "WrapTextureTransfer" }
        }
    }
end

return createMakeupSchema
