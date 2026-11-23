-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:11:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local AmpUpsell = require(BuildExperienceParent.AmpUpsell)
local Navigation = require(BuildExperienceParent.Navigation)
local NavigationRodux = require(BuildExperienceParent.NavigationRodux)
local React = require(BuildExperienceParent.React)
local RobloxAppNavigation = require(BuildExperienceParent.RobloxAppNavigation)
local SharedFlags = require(BuildExperienceParent.SharedFlags)
local UniversalAppPolicy = require(BuildExperienceParent.UniversalAppPolicy)

local useDispatch = require(BuildExperienceParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useNavigationFocus = Navigation.useNavigationFocus

local AccessResponseEnum = AmpUpsell.AmpEnums.AccessResponseEnum
local ActionStatusEnum = AmpUpsell.AmpEnums.ActionStatusEnum
local OpenAmpWizardContainer = AmpUpsell.OpenAmpWizardContainer
local NavigateBack = NavigationRodux.Thunks.NavigateBack
local NavigationCommands = RobloxAppNavigation.NavigationCommands

local FFlagSignalsNavP3Dispatch = SharedFlags.FFlagSignalsNavP3Dispatch
local FStringTriggerAgeCheckUpsellIncludingVPCAmpFeature = SharedFlags.FStringTriggerAgeCheckUpsellIncludingVPCAmpFeature
local FStringCoreContentAmpNameSpace = SharedFlags.FStringCoreContentAmpNameSpace
local num1 = game:DefineFastInt("BuildPolicyRefreshTimeoutMs", 4000)

local Status = table.freeze(
    {
        Prompting = "Prompting",
        Refreshing = "Refreshing",
        Ineligible = "Ineligible",
        Error = "Error",
        Leaving = "Leaving"
    }
)

local function wasCancelled(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    if tbl1 == nil then
        return false
    end

    for _, value in tbl1 do
        if value == ActionStatusEnum.Cancelled then
            return true
        end
    end

    return false
end

return {
    Status = Status,
    useBuildPageEligibility = function(bool1: boolean)
        local var2, var3 = UniversalAppPolicy.useAppPolicy(function(arg1)
            if not bool1 then
                return true, true
            end
            return arg1.getCanViewBuild(), arg1.getCanUseBuild()
        end)
        local var4 = useDispatch()
        local current = useNavigationFocus()
        local var6 = React.useRef(false)
        local var7 = React.useRef(current)
        local var8 = React.useRef(0)
        local var9, var10 = React.useState(false)
        local var11, var12 = React.useState(Status.Prompting)

        local onDialogDismiss = React.useCallback(function()
            var6.current = false
            local var13 = var8
            var13.current += 1
            var10(false)
            var12(Status.Leaving)
            if FFlagSignalsNavP3Dispatch then
                NavigationCommands.back(true)
                return
            end
            var4(NavigateBack(true))
        end, { var4 })

        local var14 = React.useCallback(function()
            var10(false)
            var12(Status.Refreshing)
            local var14 = var8
            var14.current += 1
            local current = var8.current

            task.delay(num1 / 1000, function()
                if var8.current ~= current then
                    return
                end

                local appFeaturePolicies = UniversalAppPolicy.getAppFeaturePolicies()
                local canViewBuild = appFeaturePolicies.getCanViewBuild()
                if appFeaturePolicies.getCanUseBuild() then
                    var10(true)
                elseif not canViewBuild then
                    var12(Status.Ineligible)
                else
                    var12(Status.Error)
                end
            end)
        end, {})

        local var15 = React.useCallback(function(granted, arg1)
            if granted == AccessResponseEnum.Granted then
                var14()
            elseif wasCancelled(arg1) then
                onDialogDismiss()
            else
                var12(Status.Error)
            end
        end, { var14, onDialogDismiss })

        React.useEffect(function()
            local current2 = var7.current
            var7.current = current

            if current and not current2 and var11 == Status.Prompting then
                var6.current = false
            elseif current and not current2 and var11 == Status.Leaving then
                var6.current = false
                var12(Status.Prompting)
            end
        end, { current, var11 })

        React.useEffect(function()
            if not bool1 then
                return
            end

            if var3 then
                local var16 = var8
                var16.current += 1
                var6.current = false
                var10(false)
                var12(Status.Prompting)
            elseif not var2 then
                local var16 = var8
                var16.current += 1
                var10(false)
                var12(Status.Ineligible)
            end
        end, { var2, var3, bool1 })

        React.useEffect(function()
            if not bool1 or not current or var11 ~= Status.Prompting or var3 or not var2 or var6.current then
                return
            end

            var6.current = true
            var4(
                OpenAmpWizardContainer(
                    FStringTriggerAgeCheckUpsellIncludingVPCAmpFeature,
                    var15,
                    nil,
                    "BuildPage",
                    nil,
                    FStringCoreContentAmpNameSpace
                )
            )
        end, {
            var2,
            var3,
            var4,
            bool1,
            var15,
            current,
            var11
        })

        React.useEffect(function()
            return function()
                local var16 = var8
                var16.current += 1
            end
        end, {})

        local canEnterBuild = not bool1 or var3 or var9

        return {
            canEnterBuild = canEnterBuild,
            status = if canEnterBuild or var2 then var11 else Status.Ineligible,
            onDialogDismiss = onDialogDismiss
        }
    end
}
