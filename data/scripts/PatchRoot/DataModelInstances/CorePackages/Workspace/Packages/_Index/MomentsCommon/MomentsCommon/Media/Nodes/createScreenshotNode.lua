-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:21:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommon = script:FindFirstAncestor("MomentsCommon")
local MomentsCommonParent = MomentsCommon.Parent

local Foundation = require(MomentsCommonParent.Foundation)
local React = require(MomentsCommonParent.React)
local Signals = require(MomentsCommonParent.Signals)

local View = Foundation.View

local _MediaTypes = require(MomentsCommon.Media.MediaTypes)
local _mediaNodeRegistry = require(MomentsCommon.Media.mediaNodeRegistry)
local preloadFastInts = require(MomentsCommon.Media.Preload.preloadFastInts)
local FFlagMomentsPreloadScreenshotImageLabel = require(MomentsCommon.Flags.FFlagMomentsPreloadScreenshotImageLabel)

local function renderCorner(cornerRadius) -- Luacid: Inlined by compiler; 2 call sites recovered
    if cornerRadius ~= nil then
        return (React.createElement("UICorner", { CornerRadius = cornerRadius }))
    end
    return nil
end

return {
    kind = "screenshot",
    create = function(arg1, arg2) -- name: createScreenshotNode
        local image = arg1.image
        assert(image ~= nil or arg1.imageContent ~= nil, "createScreenshotNode: screenshot content is required")
        local poster = arg1.poster
        local getDuration = arg1.durationSeconds or preloadFastInts.getScreenshotDurationSeconds()

        local imageContent = arg1.imageContent or Content.fromUri(image)
        local posterContent = arg1.posterContent

        if not posterContent then
            if poster == nil then
                posterContent = nil
            else
                posterContent = Content.fromUri(poster)
            end
        end

        local getPosition, var4 = Signals.createSignal(0)
        local getIsImageLoaded, var6 = Signals.createSignal(false)
        local getFailureReason, var8 = Signals.createSignal(nil)

        local bool1 = false
        local bool2 = false

        local connection = arg2.runService.Heartbeat:Connect(function(deltaTime: number)
            if bool2 or not bool1 then
                return
            end
            local var9 = getPosition(false) + deltaTime
            if getDuration <= var9 then
                var9 %= getDuration
            end
            var4(var9)
        end)

        local function refreshLoaded() -- Luacid: Inlined by compiler; 1 call site recovered
            local assetFetchStatus = arg2.contentProvider:GetAssetFetchStatus(image)
            var6(assetFetchStatus == Enum.AssetFetchStatus.Success)
            var8(
                if assetFetchStatus == Enum.AssetFetchStatus.Failure then `screenshot load failed: {assetFetchStatus.Name}` else nil
            )
        end

        local connection2 = nil
        if image ~= nil then
            connection2 = arg2.contentProvider:GetAssetFetchStatusChangedSignal(image):Connect(refreshLoaded)
            refreshLoaded()
        else
            var6(true)
        end

        local function assets(): {any} -- Luacid: Inlined by compiler; 1 call site recovered
            return if posterContent == nil then { imageContent } else { imageContent, posterContent }
        end

        return {
            id = arg1.id,
            kind = "screenshot",
            assets = assets,
            download = function()
                if bool2 then
                    return
                end

                if not FFlagMomentsPreloadScreenshotImageLabel then
                    local tbl1 = assets()
                    local var9 = nil
                    local var10 = nil
                    local tbl2 = {}

                    for _, value in tbl1, var9, var10 do
                        if value.Uri ~= nil then
                            table.insert(tbl2, value.Uri)
                        end
                    end
                    if #tbl2 > 0 then
                        arg2.contentProvider:PreloadAsync(tbl2)
                    end

                    return
                end

                local tbl1 = {}
                local imageLabel

                if imageContent.Uri == nil then
                    imageLabel = nil
                else
                    imageLabel = Instance.new("ImageLabel")
                    imageLabel.Image = imageContent.Uri

                    table.insert(tbl1, imageLabel)
                end
                if posterContent ~= nil and posterContent.Uri ~= nil then
                    table.insert(tbl1, posterContent.Uri)
                end
                if #tbl1 > 0 then
                    arg2.contentProvider:PreloadAsync(tbl1)
                end
                if imageLabel ~= nil then
                    imageLabel:Destroy()
                end
            end,
            usesDecoder = false,
            zIndex = 0,
            render = function(arg3)
                return React.createElement(View, { tag = "size-full", ZIndex = 0 }, {
                    Poster = if posterContent == nil then nil else React.createElement(
                        "ImageLabel",
                        {
                            BackgroundTransparency = 1,
                            Size = UDim2.fromScale(1, 1),
                            ScaleType = arg3.scaleType or Enum.ScaleType.Crop,
                            ImageContent = posterContent,
                            ZIndex = 1
                        },
                        {
                            Corner = renderCorner(arg3.cornerRadius)
                        }
                    ),
                    Base = React.createElement("ImageLabel", {
                        BackgroundTransparency = 1,
                        Size = UDim2.fromScale(1, 1),
                        ScaleType = arg3.scaleType or Enum.ScaleType.Crop,
                        ImageContent = imageContent,
                        ZIndex = 2,
                        ref = arg3.setSurface
                    }, {
                        Corner = renderCorner(arg3.cornerRadius)
                    })
                })
            end,
            play = function()
                bool1 = true
            end,
            pause = function()
                bool1 = false
            end,
            seek = function(num1: number)
                var4(math.clamp(num1, 0, getDuration))
            end,
            dispose = function()
                if bool2 then
                    return
                end
                bool2 = true
                bool1 = false
                connection:Disconnect()
                if connection2 ~= nil then
                    connection2:Disconnect()
                end
            end,
            getPosition = getPosition,
            getDuration = function()
                return getDuration
            end,
            getIsImageLoaded = getIsImageLoaded,
            getFailureReason = getFailureReason
        }
    end
}
