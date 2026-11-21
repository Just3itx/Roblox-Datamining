-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:31:31Z
-- Luau bytecode version: 14 | Luau type version: 3
local EditProfileBackgroundParent = script:FindFirstAncestor("EditProfileBackground").Parent

local ProfileCustomizationNetworking = require(EditProfileBackgroundParent.ProfileCustomizationNetworking)
local ProfileRoduxNetworking = require(script.Parent.ProfileRoduxNetworking)

return (ProfileCustomizationNetworking.config({ roduxNetworking = ProfileRoduxNetworking }))
