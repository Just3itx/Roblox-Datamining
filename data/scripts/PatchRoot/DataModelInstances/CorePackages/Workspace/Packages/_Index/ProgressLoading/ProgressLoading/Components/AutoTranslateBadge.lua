-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:21:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProgressLoading = script:FindFirstAncestor("ProgressLoading")
local ProgressLoadingParent = ProgressLoading.Parent

local React = require(ProgressLoadingParent.React)

local Foundation = require(ProgressLoadingParent.Foundation)
local Badge = Foundation.Badge
local View = Foundation.View
local BadgeVariant = Foundation.Enums.BadgeVariant
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local IconPosition = Foundation.Enums.IconPosition

local useLocalization = require(ProgressLoadingParent.Localization).Hooks.useLocalization

local SignalsReact = require(ProgressLoadingParent.SignalsReact)
local getLoadingScreenStore = require(ProgressLoading.Stores.getLoadingScreenStore)
local LoadingScreenTelemetry = require(ProgressLoading.LoadingScreenTelemetry)

local function AutoTranslateBadge(tbl1)
    local universeId = tbl1.universeId
    local var1 = useLocalization({ autoTranslate = "CoreScripts.TopBar.LoadingScreen.AutoTranslate" })

    local var2 = React.useCallback(function(arg1)
        local var2 = getLoadingScreenStore(arg1).getAndFetchPlayerLocalizationChoice(tostring(universeId)).data(arg1)
        return if var2 then var2.IsPlayerChoiceEnabled else nil
    end, { universeId, getLoadingScreenStore })
    local current = SignalsReact.useSignalState(var2)

    local var4 = React.useRef(current)
    var4.current = current
    React.useEffect(function()
        return function()
            if var4.current == nil then
                LoadingScreenTelemetry.countPlayerLocalizationChoiceNotReady()
            end
        end
    end, {})

    if not current then
        return nil
    end

    return React.createElement(View, {
        tag = "auto-xy padding-y-xlarge",
        testId = "--auto-translate-badge",
        GroupTransparency = tbl1.transparencyBinding,
        AnchorPoint = Vector2.new(0.5, 0),
        Position = tbl1.positionBinding:map(function(vector2: Vector2): UDim2
            return UDim2.new(0.5, 0, 0.5, vector2.Y / 2)
        end),
        Size = UDim2.fromScale(0, 0)
    }, {
        Badge = React.createElement(Badge, {
            text = var1.autoTranslate,
            variant = BadgeVariant.OverMedia,
            icon = {
                name = IconName.LanguageCharacters,
                size = IconSize.XSmall,
                position = IconPosition.Left
            }
        })
    })
end

return AutoTranslateBadge
