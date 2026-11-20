-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:20:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function createEyebrowEyelashSchema(arg1)
    assert(arg1, "attachmentName cannot be nil")
    return {
        ClassName = "Accessory",
        _children = {
            {
                Name = "ThumbnailConfiguration",
                ClassName = "Configuration",
                _optional = true,
                _children = {{ Name = "SkinColorValue", ClassName = "Color3Value" }}
            },
            {
                Name = "Handle",
                ClassName = "MeshPart",
                _children = {
                    { Name = arg1, ClassName = "Attachment" },
                    { ClassName = "WrapLayer" },
                    { ClassName = "SurfaceAppearance", _optional = true },
                    { ClassName = "StringValue", Name = "AvatarPartScaleType", _optional = true },
                    { ClassName = "TouchTransmitter", _optional = true }
                }
            }
        }
    }
end

return createEyebrowEyelashSchema
