-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:21:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local StyleParent = script:FindFirstAncestor("Style").Parent
local React = require(StyleParent.React)
local Foundation = require(StyleParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local ColorMode = Foundation.Enums.ColorMode
local getSceneOverridesStore = require(script.Parent.getSceneOverridesStore)

local function SceneOverridesRegistry(tbl1)
    local isActive = tbl1.isActive
    local var1 = useTokens()

    local var2 = React.useMemo(function()
        local color3 = var1.Color.Extended.Gray.Gray_300.Color3
        local color3_2 = var1.Color.Extended.Gray.Gray_400.Color3
        local color3_3 = var1.Color.Extended.Gray.Gray_500.Color3
        local color3_4 = var1.Color.Extended.Gray.Gray_700.Color3
        local color3_5 = var1.Color.Extended.Gray.Gray_800.Color3
        local color3_6 = var1.Color.Extended.Gray.Gray_900.Color3
        local color3_7 = var1.Color.Extended.Gray.Gray_1100.Color3

        local color3_8 = var1.Color.Surface.Surface_200.Color3
        local color3_9 = var1.Color.Surface.Surface_100.Color3

        if var1.Config.ColorMode.Name == ColorMode.Light then
            return {
                SkyboxBlockerColor = color3_2:Lerp(color3_8, 0.6),
                SkyboxBlockerTransparency = 0,
                BackPanel = color3_3:Lerp(color3_8, 0.6),
                Clouds = color3_3:Lerp(color3_8, 0.3),
                LargerShapes = color3_3:Lerp(color3_8, 0.4),
                AvatarParticles = color3_3:Lerp(color3_8, 0.4),
                Baseplate = color3:Lerp(color3_8, 0.2),
                FogColor = color3_2:Lerp(color3_8, 0.4),
                FogStart = 400,
                FogEnd = 500
            }
        end

        return {
            SkyboxBlockerColor = color3_5:Lerp(color3_8, 0.3),
            SkyboxBlockerTransparency = 0,
            BackPanel = color3_4:Lerp(color3_8, 0.3),
            Clouds = color3_4:Lerp(color3_8, 0.3),
            LargerShapes = color3_4:Lerp(color3_9, 0.4),
            AvatarParticles = color3_4:Lerp(color3_8, 0.4),
            Baseplate = color3_6:Lerp(color3_8, 0.2),
            FogColor = color3_7:Lerp(color3_8, 0.3),
            FogStart = 400,
            FogEnd = 500
        }
    end, { var1 })

    React.useEffect(function()
        local sceneOverridesStore = getSceneOverridesStore()
        if isActive then
            sceneOverridesStore.setSceneOverrides(var2)
            return function()
                sceneOverridesStore.setSceneOverrides(nil)
            end
        end
    end, { isActive, var2 })

    return tbl1.children
end

return SceneOverridesRegistry
