-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:11:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local GuiService = game:GetService("GuiService")

local AvatarIdentification = require(scriptParentParentParent.AvatarIdentification).AvatarIdentification
local Dash = require(scriptParentParentParent.Dash)

local getAvatarAssets = require(scriptParentParent.Utils.getAvatarAssets)

local num1 = game:DefineFastInt("CaptureMetadataGetAvatarsTimeoutMs", 150)
local num2 = game:DefineFastInt("CaptureMetadataMaxAvatars", 5)

local num3 = game:DefineFastInt("CaptureMetadataMinAvatarBoundingBoxPixels", 200)
local num4 = game:DefineFastInt("CaptureMetadataMinHitRatePercentage", 50)

local function getViewportSize() -- Luacid: Inlined by compiler; 1 call site recovered
    local currentCamera = workspace.CurrentCamera
    if currentCamera then
        return currentCamera.ViewportSize
    end
end
local round = math.round
local function vec2ToTable(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return {
        x = round(arg1.X),
        y = round(arg1.Y)
    }
end
return function()
    local viewportSize = getViewportSize()

    if not viewportSize then
        return {}
    end

    local num5 = num1 / 1000
    local visibleAvatars = AvatarIdentification.getVisibleAvatars(true, num5)
    local var1 = Dash.values(visibleAvatars)

    local rawScreenScale = GuiService:GetRawScreenScale()
    for _, value in var1 do
        value.boundingBox.min = value.boundingBox.min * viewportSize * rawScreenScale
        value.boundingBox.max = value.boundingBox.max * viewportSize * rawScreenScale
    end

    table.sort(var1, function(arg1, arg2): boolean
        return (arg1.boundingBox.max - arg1.boundingBox.min).Magnitude > (arg2.boundingBox.max - arg2.boundingBox.min).Magnitude
    end)

    local num6 = 0
    local result = ({})

    for _, value in var1 do
        if num2 <= num6 then
            break
        end

        num6 += 1

        if value.hitRate < num4 / 100 then
            continue
        end

        if (value.boundingBox.max - value.boundingBox.min).Magnitude < num3 then
            break
        end

        local player = value.player
        local avatarItems = getAvatarAssets(player.Character)
        local userId = player.UserId
        result[userId] = {
            avatarItems = avatarItems,
            boundingBox = {
                min = vec2ToTable(value.boundingBox.min),
                max = vec2ToTable(value.boundingBox.max)
            }
        }
    end

    return result
end
