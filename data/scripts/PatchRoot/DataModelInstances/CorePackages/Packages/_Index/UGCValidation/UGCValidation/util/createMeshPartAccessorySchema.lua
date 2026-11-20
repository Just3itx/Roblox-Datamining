-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:20:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function createMeshPartAccessorySchema(arg1)
    assert(arg1, "attachmentName cannot be nil")
    return {
        ClassName = "Accessory",
        _children = {
            {
                Name = "ThumbnailConfiguration",
                ClassName = "Configuration",
                _optional = true,
                _children = {
                    { Name = "ThumbnailCameraTarget", ClassName = "ObjectValue" },
                    { Name = "ThumbnailCameraValue", ClassName = "CFrameValue" }
                }
            },
            {
                Name = "Handle",
                ClassName = "MeshPart",
                _children = {
                    { Name = arg1, ClassName = "Attachment" },
                    {
                        ClassName = "SurfaceAppearance",
                        Name = "SurfaceAppearance",
                        _optional = true
                    },
                    { ClassName = "StringValue", Name = "AvatarPartScaleType", _optional = true },
                    { ClassName = "TouchTransmitter", Name = "TouchInterest", _optional = true }
                }
            }
        }
    }
end

return createMeshPartAccessorySchema
