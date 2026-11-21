-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:10:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local CapturesCommonNetworking = require(scriptParentParent.Networking).CapturesCommonNetworking
local React = require(scriptParentParentParent.React)
local RoactUtils = require(scriptParentParentParent.RoactUtils)

local AssetType = require(scriptParentParent.Enums.AssetType)
local ThumbnailState = require(scriptParentParent.Enums.ThumbnailState)
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useEffect = React.useEffect
local useState = React.useState

local num1 = game:DefineFastInt("ContentPostsThumbnailsInitialDelayTimeMs", 100)
local num2 = game:DefineFastInt("ContentPostsThumbnailsMaxRetries", 10)

local function makeThumbnailRequest(arg1, assetId: number, size: string)
    return arg1(
        CapturesCommonNetworking.GetThumbnailByAssetId.API({ assetId = assetId, assetType = AssetType.Screenshot, size = size })
    ):andThen(
        function(arg2)
            local var1 = arg2.responseBody.data[1]

            return if var1.imageUrl and var1.imageUrl ~= "" and var1.state == ThumbnailState.Completed then var1.imageUrl else nil
        end
    ):catch(
        function(_)
            return nil
        end
    ):await()
end

return function(assetId: number?, num3: number, num4: number)
    local var1 = useDispatch()

    local var2, var3 = useState("")
    local var4, var5 = useState(false)

    local str1 = tostring(num3) .. "x" .. tostring(num4)

    useEffect(function()
        local bool1 = false
        local num5 = num1
        local num6 = num2

        var5(false)
        var3("")

        if not assetId then
            return
        end

        task.spawn(function()
            while not bool1 and num6 > 0 do
                local var6, var7 = makeThumbnailRequest(var1, assetId, str1)
                if bool1 then
                    break
                end

                if var6 and var7 then
                    var3(var7)
                    var5(true)
                    return
                end

                task.wait(num5 / 1000)
                num5 *= 2
                num6 -= 1
            end
        end)

        return function()
            bool1 = true
        end
    end, { assetId, str1 })

    return var2, var4
end
