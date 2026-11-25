-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T23:00:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local WhatsNew = script:FindFirstAncestor("WhatsNew")
local WhatsNewParent = WhatsNew.Parent

local Enums = require(WhatsNew.Enums)
local Foundation = require(WhatsNewParent.Foundation)
local Localization = require(WhatsNewParent.Localization)
local React = require(WhatsNewParent.React)
local GetWhatsNewStore = require(WhatsNew.store.GetWhatsNewStore)
local useWhatsNewRuntimeState = require(WhatsNew.hooks.useWhatsNewRuntimeState)
local WhatsNewTelemetry = require(WhatsNew.telemetry.WhatsNewTelemetry)

local EducationalTooltip = Foundation.EducationalTooltip
local View = Foundation.View
local ButtonVariant = Foundation.Enums.ButtonVariant
local PopoverAlign = Foundation.Enums.PopoverAlign
local PopoverSide = Foundation.Enums.PopoverSide
local useLocalization = Localization.Hooks.useLocalization

local function isRectReady(vector2: Vector2): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return vector2.X > 0 and vector2.Y > 0
end

return React.memo(function() -- name: WhatsNewTourtip
    local whatsNewStore = GetWhatsNewStore()
    local var1 = useWhatsNewRuntimeState()
    local currentEntry = var1.currentEntry
    local globalStepIndex = var1.globalStepIndex
    local bool1 = var1.surface == Enums.WhatsNewSurface.TourTip and currentEntry ~= nil and globalStepIndex ~= nil
    local var2 = React.useRef(nil)
    local anchorRef = React.useRef(nil)

    local var4 = useLocalization({
        back = "CommonUI.Controls.Action.Back",
        next = "CommonUI.Controls.Action.Next",
        done = "CommonUI.Controls.Action.Done"
    })

    local current = if globalStepIndex == nil then 0 else globalStepIndex + 1
    local globalTotalSteps = var1.globalTotalSteps
    local isDisabled = bool1 and globalStepIndex == 0
    local bool3 = bool1 and globalTotalSteps <= current
    local anchorRef2 = if bool1 and currentEntry ~= nil then whatsNewStore.getAnchorRef(currentEntry.anchorId) else nil
    anchorRef.current = anchorRef2
    local bool4 = not (anchorRef2 == nil) and isRectReady(anchorRef2.AbsoluteSize)

    React.useEffect(function()
        if not bool1 or currentEntry == nil then
            var2.current = nil
        elseif var2.current ~= currentEntry.id then
            var2.current = currentEntry.id
            WhatsNewTelemetry.logTourtipInteraction(
                WhatsNewTelemetry.InteractionType.IMPRESSION,
                currentEntry.id,
                nil,
                whatsNewStore.getRuntimeState()
            )
        end
    end, { bool1, currentEntry, whatsNewStore })

    local onActivated = React.useCallback(function()
        if currentEntry == nil then
            return
        end
        whatsNewStore.next()
    end, { whatsNewStore, currentEntry })

    local var3 = React.useCallback(function()
        if currentEntry == nil then
            return
        end
        whatsNewStore.back()
    end, { whatsNewStore, currentEntry })

    local onClose = React.useCallback(function()
        if currentEntry == nil then
            return
        end
        whatsNewStore.completeTour({ earlyDismiss = true })
    end, { whatsNewStore, currentEntry })

    if not bool1 or currentEntry == nil or globalStepIndex == nil then
        return nil
    end

    if anchorRef2 == nil or not bool4 then
        return nil
    end

    local bool5 = globalTotalSteps > 1
    local actions = {}
    local var9

    if bool5 then
        table.insert(actions, {
            isDisabled = isDisabled,
            text = var4.back,
            variant = ButtonVariant.Standard,
            onActivated = var3,
            testId = "whats-new-tourtip--action-1"
        })

        table.insert(actions, {
            text = if bool3 then var4.done else var4.next,
            variant = ButtonVariant.Emphasis,
            onActivated = onActivated,
            testId = "whats-new-tourtip--action-2"
        })
        var9 = { current = current, total = globalTotalSteps }
    else
        var9 = nil
    end

    local str1 = `{currentEntry.id}-{anchorRef2:GetFullName()}`

    return React.createElement(View, {
        tag = "size-full",
        BackgroundTransparency = 1,
        Active = false
    }, {
        [str1] = React.createElement(EducationalTooltip, {
            anchorRef = anchorRef,
            title = currentEntry.title,
            text = currentEntry.text,
            side = currentEntry.side or PopoverSide.Bottom,
            align = currentEntry.align or PopoverAlign.Center,
            isOpen = true,
            hasActions = bool5,
            showSteps = bool5,
            steps = var9,
            onClose = onClose,
            actions = actions,
            testId = "whats-new-tourtip"
        })
    })
end)
