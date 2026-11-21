-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:31:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfileBackground = script:FindFirstAncestor("EditProfileBackground")
local EditProfileBackgroundParent = EditProfileBackground.Parent
local React = require(EditProfileBackgroundParent.React)
local useNavigation = require(EditProfileBackgroundParent.Navigation).useNavigation
local editProfileBackgroundTopBar = require(EditProfileBackground.Components.editProfileBackgroundTopBar)
local useScreenSize = require(EditProfileBackgroundParent.RobloxAppHooks).useScreenSize
local useLocalUserId = require(EditProfileBackgroundParent.RobloxAppHooks).useLocalUserId
local SelectionCarousel = require(EditProfileBackground.Components.SelectionCarousel)
local DisplayBackground = require(EditProfileBackground.Components.DisplayBackground)
local ProfileCustomizationNetworking = require(EditProfileBackground.Networking.ProfileCustomizationNetworking)
local useDispatch = require(EditProfileBackgroundParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useSelector = require(EditProfileBackgroundParent.RoactUtils).Hooks.RoactRodux.useSelector
local useEffectOnMount = require(EditProfileBackgroundParent.RoactUtils).Hooks.useEffectOnMount
local View = require(EditProfileBackgroundParent.Foundation).View
local SocialToast = require(EditProfileBackgroundParent.SocialToast)
local ErrorHandling = require(EditProfileBackground.Common.ErrorHandling)
local Constants = require(EditProfileBackground.Common.Constants)
local FocusNavigationUtils = require(EditProfileBackgroundParent.FocusNavigationUtils)
local FocusNavigableSurfaceWrapper = FocusNavigationUtils.FocusNavigableSurfaceWrapper
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local InputHandlers = require(EditProfileBackgroundParent.InputHandlers)
local Cryo = require(EditProfileBackgroundParent.Cryo)

local Analytics = require(EditProfileBackground.Analytics)
local useAnalytics = Analytics.useAnalytics
local EventNames = Analytics.EventNames
local ErrorTypes = Analytics.ErrorTypes

local var1 = Constants.BACKGROUND_ASSET_IDS[1]

local DEFAULT_ERROR_MESSAGES = ErrorHandling.DEFAULT_ERROR_MESSAGES

local InsertService = game:GetService("InsertService")

local function preloadBackgroundAssets(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    task.spawn(function()
        local var2 = Cryo.Dictionary.join(
            Constants.DEFAULT_BACKGROUND_ASSET_IDS,
            Cryo.List.filter(Constants.BACKGROUND_ASSET_IDS, function(arg2): boolean
                return arg2 ~= var1
            end)
        )

        for _, value in ipairs(var2) do
            local success, result = pcall(function(): Instance
                return InsertService:LoadAsset(value)
            end)

            if success and result then
                result:Destroy()
            else
                arg1.fireAnalyticsEvent(EventNames.EditProfileBackgroundFailure, { errorType = ErrorTypes.AssetPreloadFailed })
            end
        end
    end)
end

local function EditProfileBackgroundPage(tbl1)
    local var2 = useScreenSize()
    local var3 = useLocalUserId()

    local var4 = useDispatch()
    local var5 = SocialToast.useOpenToast()
    local analytics = useAnalytics()

    local var7 = useSelector(function(arg1)
        if arg1.GlobalGuiInset then
            return arg1.GlobalGuiInset.bottom + 5
        end

        return 0
    end)

    useEffectOnMount(function()
        analytics.fireAnalyticsEvent(EventNames.EditProfileBackgroundOpened)

        local startTime = tick()

        preloadBackgroundAssets(analytics)

        local statValue = tick() - startTime

        analytics.fireAnalyticsEvent(EventNames.EditProfileBackgroundLoadingStage, { statValue = statValue, status = "loaded" })
    end)

    local var8 = if tbl1.profileBackgroundData and tbl1.profileBackgroundData.assetId then tbl1.profileBackgroundData.assetId else var1
    local var9, var10 = React.useState(nil)

    local currentBackgroundId = var9 or var8

    local var12 = React.useMemo(function()
        local width = math.min(640, var2.X)
        local buttonsPerRow = if width >= 540 then 8 else 4
        local numRows = math.ceil(8 / buttonsPerRow)
        local buttonSize = (width - 32 - (buttonsPerRow - 1) * 16) / buttonsPerRow
        local carouselHeight = numRows * buttonSize + (numRows + 1) * 16
        local contentAreaHeight = var2.Y - 48 - 40 - 24 - var7
        return {
            width = width,
            buttonSize = buttonSize,
            carouselHeight = carouselHeight,
            contentAreaHeight = contentAreaHeight,
            displayBackgroundHeight = contentAreaHeight - carouselHeight,
            buttonsPerRow = buttonsPerRow,
            numRows = numRows
        }
    end, { var2, var7 })

    local var13 = useNavigation()

    local function onClose() -- Luacid: Inlined by compiler; 1 call site recovered
        if tbl1.onBackgroundChanged then
            tbl1.onBackgroundChanged()
        end
        var13.goBack()
    end

    local function onBackgroundSelected(num1: number)
        analytics.fireAnalyticsEvent(EventNames.BackgroundSelected, { backgroundId = num1 })

        var10(num1)

        task.spawn(function()
            local tbl2 = {
                profileEntity = {
                    id = tostring(var3),
                    type = "User"
                },
                customizedComponents = {
                    profileBackground = { assetId = num1 }
                }
            }

            var4(ProfileCustomizationNetworking.UpdateProfileCustomization.API(tbl2)):andThen(function(_)
                if tbl1.onBackgroundChanged then
                    tbl1.onBackgroundChanged()
                end
            end):catch(function(arg1)
                analytics.fireAnalyticsEvent(
                    EventNames.EditProfileBackgroundFailure,
                    {
                        errorType = ErrorTypes.BackgroundSaveFailed,
                        errorCode = tostring(arg1 and arg1.StatusCode or "unknown")
                    }
                )
                var5({ toastTitle = DEFAULT_ERROR_MESSAGES.SAVE_BACKGROUND, iconImage = { Image = "icons/actions/error" } })
            end)
        end)
    end

    local createElement = React.createElement
    local var14 = FocusNavigableSurfaceWrapper

    local tbl2 = {
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp,
        isIsolated = true,
        customEventHandlers = {
            [FocusNavigationEventNameEnum.NavigateBack] = {
                handler = InputHandlers.onRelease(function(arg1)
                    onClose()
                    arg1:cancel()
                end)
            }
        }
    }

    return createElement(var14, tbl2, {
        React.createElement(View, {
            tag = "size-full bg-surface-0 anchor-top-right position-top-right"
        }, {
            SizeConstraint = React.createElement("UISizeConstraint", { MaxSize = Vector2.new(640, math.huge) }),
            Layout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 24)
            }),
            TopPadding = React.createElement(View, { tag = "size-full-500" }),
            TopBar = React.createElement(editProfileBackgroundTopBar, { layoutOrder = 1, onClose = onClose }),
            ContentArea = React.createElement(View, {
                Size = UDim2.new(1, 0, 0, var12.contentAreaHeight),
                LayoutOrder = 2
            }, {
                Layout = React.createElement("UIListLayout", {
                    FillDirection = Enum.FillDirection.Vertical,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, 0)
                }),
                BackgroundDisplay = React.createElement(DisplayBackground, {
                    LayoutOrder = 1,
                    height = var12.displayBackgroundHeight,
                    currentBackgroundId = currentBackgroundId,
                    userId = tonumber(var3),
                    analytics = analytics
                }),
                SelectionCarousel = React.createElement(SelectionCarousel, {
                    LayoutOrder = 2,
                    height = var12.carouselHeight,
                    width = var12.width,
                    buttonSize = var12.buttonSize,
                    buttonsPerRow = var12.buttonsPerRow,
                    numRows = var12.numRows,
                    onBackgroundSelected = onBackgroundSelected,
                    currentBackgroundId = currentBackgroundId
                })
            })
        })
    })
end

return EditProfileBackgroundPage
