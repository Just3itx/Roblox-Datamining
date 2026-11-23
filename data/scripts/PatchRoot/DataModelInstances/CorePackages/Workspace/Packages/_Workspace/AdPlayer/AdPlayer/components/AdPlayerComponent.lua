-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:30:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")

local AdPlayer = script:FindFirstAncestor("AdPlayer")
local AdPlayerParent = AdPlayer.Parent
local React = require(AdPlayerParent.React)
local Foundation = require(AdPlayerParent.Foundation)
local View = Foundation.View
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance
local useTokens = Foundation.Hooks.useTokens

local ReportAdPopup = require(AdPlayerParent.AdGuiInteractivity).ReportAdPopup
local components = AdPlayer.components
local VideoOverlayComponent = require(components.VideoOverlayComponent)
local ExitConfirmationModalComponent = require(components.ExitConfirmationModalComponent)

local var1 = table.freeze({ Loading = 1, Paused = 2, Playing = 3 })

local function AdPlayerComponent(tbl1)
    local var2 = useTokens()
    local totalDuration, var4 = React.useState(0)
    local alpha, var6 = React.useBinding(0)
    local var7, var8 = React.useState(false)
    local showReportAdPopup, var10 = React.useState(false)
    local var11, var12 = React.useState(var1.Loading)
    local ref = React.useRef(nil)
    local var3 = React.useRef(nil)

    local function dismissParentModals() -- Luacid: Inlined by compiler; 2 call sites recovered
        var8(false)
        var10(false)
    end

    local function dismissModals() -- Luacid: Inlined by compiler; 1 call site recovered
        dismissParentModals()
        local value = ref:getValue()
        if value then
            value.dismissModals()
        end
    end

    React.useEffect(function()
        local value = var3:getValue()
        if not value.IsLoaded then
            value.Loaded:Wait()
        end

        var12(var1.Playing)
        var4(value.TimeLength)
        value.Ended:Connect(tbl1.onComplete)

        local connection = RunService.RenderStepped:Connect(function()
            if value.TimeLength > 0 then
                var6(value.TimePosition / value.TimeLength)
            end
        end)

        tbl1.onVideoFrameLoaded(value)

        return function()
            connection:Disconnect()
        end
    end, {})

    local parentModalOpen = var7 or showReportAdPopup
    local playing = var11 == var1.Playing and not parentModalOpen
    local testAdDisclaimer = if RunService:IsStudio() then React.createElement(require(components.TestAdDisclaimerComponent), { isEligible = tbl1.isEligible }) else nil

    return React.createElement(View, {
        tag = "size-full",
        onActivated = function() end,
        stateLayer = {
            affordance = StateLayerAffordance.None
        },
        backgroundStyle = var2.Color.Extended.Black.Black_100
    }, {
        videoFrame = React.createElement("VideoFrame", {
            Size = UDim2.fromScale(1, 1),
            Position = UDim2.fromScale(0.5, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Video = tbl1.creativeAssetUrl,
            Playing = playing,
            BorderSizePixel = 0,
            Transparency = if var7 then 0.4 else 0,
            ref = var3
        }, {
            React.createElement("UIAspectRatioConstraint", { AspectRatio = 16 / 9, AspectType = Enum.AspectType.FitWithinMaxSize }),
            testAdDisclaimer = testAdDisclaimer,
            confirmExitModal = React.createElement(ExitConfirmationModalComponent, {
                Enabled = var7,
                onCancel = function()
                    var8(false)
                end,
                onConfirm = tbl1.onCancel
            }),
            reportAdModal = React.createElement(ReportAdPopup, {
                showReportAdPopup = showReportAdPopup,
                onClose = function()
                    var10(false)
                end,
                onOpen = function()
                    var10(true)
                end,
                adInfo = tbl1.getReportAdInfo()
            }),
            videoOverlay = React.createElement(VideoOverlayComponent, {
                ref = ref,
                alpha = alpha,
                totalDuration = totalDuration,
                parentModalOpen = parentModalOpen,
                dismissModals = dismissParentModals,
                parentPaused = not playing,
                showWhyThisAd = tbl1.showWhyThisAd,
                setPaused = function(arg1)
                    if var11 ~= var1.Loading then
                        var12(if arg1 then var1.Paused else var1.Playing)
                    end
                end,
                showReportAdModal = function()
                    var10(true)
                end,
                showExitConfirmationModal = function()
                    dismissModals()
                    var8(true)
                end
            })
        })
    })
end

return AdPlayerComponent
