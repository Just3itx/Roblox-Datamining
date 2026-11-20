-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:00:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoactAppExperiment = script:FindFirstAncestor("RoactAppExperiment")

local React = require(RoactAppExperiment.Parent.React)
local usePrevious = require(script.Parent.usePrevious)
local useIXPService = require(RoactAppExperiment.useIXPService)

local function getLayerNamesKey(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    local str1 = ""
    for i, value in ipairs(tbl1) do
        if i > 1 then
            str1 ..= ","
        end
        str1 ..= value
    end
    return str1
end

local function makeUseExperiment(arg1, arg2, arg3, arg4, arg5)
    return function(tbl1, func1: (...any) -> (...any), bool1: boolean?)
        if bool1 == nil then
            bool1 = true
        end

        local var1 = useIXPService()

        assert(type(tbl1) == "table", "useExperiment expects layerNames to be a list of layers")
        assert(type(func1) == "function", "useExperiment expects mapLayers to be a function")

        local function getNewLayerToVariables()
            local newLayerToVariables = ({})
            for _, value in ipairs(tbl1) do
                newLayerToVariables[value] = var1[arg3](var1, value)
                if newLayerToVariables[value] and not next(newLayerToVariables[value]) then
                    newLayerToVariables[value] = nil
                end
            end

            return newLayerToVariables
        end

        local function getLoadingStatus() -- Luacid: Inlined by compiler; 3 call sites recovered
            return var1[arg2](var1)
        end

        local var2, var3 = React.useState(getNewLayerToVariables)
        local var4, var5 = React.useState(getLoadingStatus)
        local layerNamesKey = getLayerNamesKey(tbl1)

        React.useEffect(function()
            if var1 == nil then
                return function() end
            end

            local function updateStateLayerData() -- Luacid: Inlined by compiler; 2 call sites recovered
                local loadingStatus = getLoadingStatus()

                local newLayerToVariables = getNewLayerToVariables()

                var3(function(arg6)
                    local bool2 = not next(arg6)
                    return if not next(newLayerToVariables) == bool2 then arg6 else newLayerToVariables
                end)

                var5(loadingStatus)
            end

            local connection = var1[arg1]:Connect(function(_)
                updateStateLayerData()
            end)

            updateStateLayerData()

            return function()
                if connection ~= nil then
                    connection:Disconnect()
                end
            end
        end, { var1, layerNamesKey })

        local var6 = usePrevious(var4) or Enum.IXPLoadingStatus.None

        React.useEffect(function()
            if not bool1 or var1 == nil or var4 ~= Enum.IXPLoadingStatus.Initialized or var6 == Enum.IXPLoadingStatus.Initialized then
                return
            end
            for _, value in ipairs(tbl1) do
                if var1[arg5](var1, value) == Enum.IXPLoadingStatus.Initialized then
                    var1[arg4](var1, value)
                end
            end
        end, {
            var1,
            layerNamesKey,
            bool1,
            var4,
            var6
        })

        return func1(var2)
    end
end
return makeUseExperiment
