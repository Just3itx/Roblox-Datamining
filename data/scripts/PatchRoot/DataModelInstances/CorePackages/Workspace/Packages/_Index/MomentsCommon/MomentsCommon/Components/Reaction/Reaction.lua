-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:01:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")

local MomentsCommon = script:FindFirstAncestor("MomentsCommon")
local MomentsCommonParent = MomentsCommon.Parent

local Foundation = require(MomentsCommonParent.Foundation)
local React = require(MomentsCommonParent.React)

local Image = Foundation.Image

local _ReactionSize = require(MomentsCommon.Enums.ReactionSize)
local _ReactionType = require(MomentsCommon.Enums.ReactionType)

local AnimationData = require(script.Parent.AnimationData)
local ReactionAnimation = require(script.Parent.ReactionAnimation)
local ReactionAssets = require(script.Parent.ReactionAssets)

local tbl1 = ({})

local function warnMissingAnimation(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    if tbl1[str1] then
        return
    end

    warn(`Reaction animation missing for {str1}`)
    tbl1[str1] = true
end

local function getStaticImageData(reactionType, size)
    local image = ReactionAssets.getStaticImageUri(reactionType, size)

    if image == nil then
        return nil
    end

    return {
        Image = image,
        ImageRectSize = Vector2.new(0, 0),
        ImageRectOffset = Vector2.new(0, 0)
    }
end

local function setFrame(arg1, num1: number, tbl2, callback: (...any) -> (...any), callback2: (...any) -> (...any)) -- Luacid: Inlined by compiler; 3 call sites recovered
    local frameRect = ReactionAnimation.getFrameRect(arg1, num1)
    tbl2.current = frameRect.frameIndex
    callback(frameRect.offset)
    callback2(frameRect.size)
end

return React.memo(React.forwardRef(function(tbl2, arg1) -- name: Reaction
    local assetKey = ReactionAssets.getAssetKey(tbl2.reactionType)
    local var1 = if assetKey == nil then nil else AnimationData(assetKey)

    local var2 = React.useMemo(function()
        return (getStaticImageData(tbl2.reactionType, tbl2.size))
    end, { tbl2.reactionType, tbl2.size })
    local sizePixels = ReactionAssets.getSizePixels(tbl2.size)
    local bool1 = not (assetKey == nil) and var1 ~= nil
    local var3, var4 = React.useState(false)
    if tbl2.isPlaying ~= nil then
        var3 = tbl2.isPlaying
    end

    local var5 = var3 and bool1
    local var6 = if var2 ~= nil then var2.ImageRectOffset else Vector2.zero
    local var7 = if var2 ~= nil then var2.ImageRectSize else Vector2.zero
    local offset, var9 = React.useBinding(var6)
    local size, var11 = React.useBinding(var7)

    local var12 = React.useRef(1)
    local var13 = React.useRef(0)
    local var14 = React.useRef(false)

    React.useEffect(function()
        if var5 and var1 ~= nil then
            var13.current = 0
            var14.current = false
            setFrame(var1, 1, var12, var9, var11)
        elseif var2 ~= nil then
            var13.current = 0
            var14.current = false
            var12.current = 1
            var9(var2.ImageRectOffset)
            var11(var2.ImageRectSize)
        end

        if not var3 or bool1 then
            return
        end

        local var15 = assetKey or tostring(tbl2.reactionType)
        warnMissingAnimation(var15)
    end, {
        var5,
        var1,
        var2,
        tbl2.reactionType,
        var3,
        tbl2.loop,
        bool1,
        assetKey
    })

    React.useEffect(function()
        if not var5 or var1 == nil then
            return nil
        end

        local connection = RunService.Heartbeat:Connect(function(deltaTime: number)
            if var14.current then
                return
            end

            local var15 = var13
            var15.current += deltaTime

            if not tbl2.loop and var13.current >= ReactionAnimation.getDurationSeconds(var1) then
                setFrame(var1, var1.frameCount, var12, var9, var11)
                var14.current = true
                var4(false)
                return
            end

            local frameIndex = ReactionAnimation.getFrameIndex(var1, var13.current, tbl2.loop == true)
            if frameIndex ~= var12.current then
                setFrame(var1, frameIndex, var12, var9, var11)
            end
        end)

        return function()
            connection:Disconnect()
        end
    end, { var5, var1, tbl2.loop })

    React.useImperativeHandle(arg1, function()
        return {
            start = function()
                if tbl2.isPlaying == nil then
                    var4(true)
                end
            end,
            stop = function()
                if tbl2.isPlaying == nil then
                    var4(false)
                end
            end
        }
    end, { tbl2.isPlaying })

    local image = if var5 and assetKey ~= nil then ReactionAssets.getAnimatedImageUri(assetKey) elseif var2 == nil then nil else var2.Image

    if image == nil or sizePixels == nil then
        return nil
    end

    return React.createElement(Image, {
        AnchorPoint = tbl2.AnchorPoint,
        BackgroundTransparency = 1,
        Image = image,
        LayoutOrder = tbl2.LayoutOrder,
        Position = tbl2.Position,
        ScaleType = Enum.ScaleType.Fit,
        Size = UDim2.fromOffset(sizePixels, sizePixels),
        Visible = tbl2.Visible,
        ZIndex = tbl2.ZIndex,
        scale = tbl2.scale,
        imageRect = { offset = offset, size = size },
        imageStyle = tbl2.imageStyle,
        testId = tbl2.testId
    })
end))
