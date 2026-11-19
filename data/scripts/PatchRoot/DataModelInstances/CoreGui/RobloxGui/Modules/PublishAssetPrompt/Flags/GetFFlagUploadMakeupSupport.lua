-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:20:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("UploadMakeupSupport", false)

local GetFFlagSingleUploadMakeupSupport = require(script.Parent.GetFFlagSingleUploadMakeupSupport)

return function()
    return GetFFlagSingleUploadMakeupSupport() and game:GetFastFlag("UploadMakeupSupport")
end
