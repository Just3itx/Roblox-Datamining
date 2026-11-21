-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:50:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BodyAssetTypes = require(script.Parent.Parent.Constants).BodyAssetTypes

local function buildBodySlotViewportProps(color3: Color3, tbl1)
    local lookAssetInfos = ({})

    local str1 = color3:ToHex()

    for _, value in BodyAssetTypes do
        local str2 = tostring(value.Value)
        local var1 = tbl1[str2]

        if not var1 then
            continue
        end

        for id, _ in var1 do
            local tbl3 = {
                id = id,
                assetType = tonumber(str2),
                quantityOwned = 1
            }
            lookAssetInfos[id] = tbl3
        end
    end

    return {
        lookDetails = {
            lookAssetInfos = lookAssetInfos,
            lookBundleInfos = {},
            avatarProperties = {
                bodyColor3s = {
                    headColor3 = str1,
                    leftArmColor3 = str1,
                    leftLegColor3 = str1,
                    rightArmColor3 = str1,
                    rightLegColor3 = str1,
                    torsoColor3 = str1
                },
                playerAvatarType = "R15"
            }
        }
    }
end

return buildBodySlotViewportProps
