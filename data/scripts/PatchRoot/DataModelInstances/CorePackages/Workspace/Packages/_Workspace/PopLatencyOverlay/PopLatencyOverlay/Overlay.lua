-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:11:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local scriptParentParent = script.Parent.Parent
local React = require(scriptParentParent.React)

local canToggleForProbe = require(script.Parent.canToggleForProbe)
local format = require(script.Parent.format)
local isToggleChord = require(script.Parent.isToggleChord)

local function PopLatencyOverlay(arg1)
    local var1, var2 = React.useState(false)
    local var3, var4 = React.useState("Waiting for first probe round…")
    local bool1 = arg1.failClosedOnProbeCheck == true
    local authorizeToggle = arg1.authorizeToggle
    local authorizationVersion = arg1.authorizationVersion
    local bool2 = arg1.deferServiceUntilToggle == true

    local var5 = React.useRef(nil)

    local var6 = React.useRef(os.clock())

    local var7 = React.useCallback(function()
        if var5.current then
            return var5.current
        end

        local success, result = pcall(function(): PopLatencyService
            return game:GetService("PopLatencyService")
        end)
        if success and result then
            var5.current = result
        else
            warn("[PopLatencyOverlay] PopLatencyService not available in this build")
        end
        return var5.current
    end, {})

    React.useEffect(function()
        if not bool2 then
            var7()
        end
    end, { var7, bool2 })

    React.useEffect(function()
        local connection = UserInputService.InputBegan:Connect(function(input: InputObject)
            if not isToggleChord(input) then
                return
            end

            local var8 = var5.current or var7()
            if not canToggleForProbe(var8, bool1) then
                return
            end

            local function toggle() -- Luacid: Inlined by compiler; 2 call sites recovered
                if canToggleForProbe(var5.current, bool1) then
                    var2(function(arg2): boolean
                        return not arg2
                    end)
                end
            end

            if not authorizeToggle then
                toggle()
                return
            end

            task.spawn(function()
                if authorizeToggle() then
                    toggle()
                end
            end)
        end)

        return function()
            connection:Disconnect()
        end
    end, { var7, authorizeToggle, bool1 })

    React.useEffect(function()
        var2(false)
    end, { authorizationVersion })

    React.useEffect(function()
        if not var1 then
            return
        end
        local current = var5.current
        if not current then
            var4(format.colorTag(format.COLOR_RED, format.escapeRich("PopLatencyService not available in this build.")))

            return
        end
        local bool3 = true
        task.spawn(function()
            while bool3 do
                local success, result = pcall(function()
                    return current:GetSnapshot()
                end)
                if bool3 then
                    if success and result then
                        local intervalMs = result[1] and result[1].intervalMs or 0
                        local roundCount = result[1] and result[1].roundCount or 0
                        var4(format.renderSnapshot(result, roundCount, os.clock() - var6.current, intervalMs))
                    elseif not success then
                        var4(format.colorTag(format.COLOR_RED, format.escapeRich("error: " .. tostring(result))))
                    end
                end
                task.wait(format.POLL_INTERVAL_SECONDS)
            end
        end)
        return function()
            bool3 = false
        end
    end, { var1 })

    if not var1 then
        return nil
    end

    local createElement = React.createElement
    local tbl1 = {
        Name = "Container",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 960, 0, 660),
        AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundColor3 = format.COLOR_BG,
        BackgroundTransparency = 0.05,
        BorderSizePixel = 0
    }

    local tbl2 = {
        Padding = React.createElement("UIPadding", { PaddingRight = UDim.new(0, 8), PaddingBottom = UDim.new(0, 6) }),
        Stroke = React.createElement("UIStroke", { Color = format.COLOR_BORDER, Thickness = 1 }),
        Panel = React.createElement("TextLabel", {
            Name = "Panel",
            AnchorPoint = Vector2.new(0, 0),
            Position = UDim2.new(0, 8, 0, 6),
            Size = UDim2.new(0, 944, 0, 648),
            AutomaticSize = Enum.AutomaticSize.XY,
            BackgroundTransparency = 1,
            Font = Enum.Font.Code,
            TextSize = format.TEXT_SIZE,
            TextColor3 = format.COLOR_HEADER,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            RichText = true,
            Text = var3
        }),
        Close = 0
    }

    local createElement2 = React.createElement
    local tbl3 = {
        Name = "Close",
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, -2, 0, 4),
        Size = UDim2.new(0, 22, 0, 22),
        BackgroundTransparency = 1,
        Font = Enum.Font.Code,
        TextSize = 18,
        TextColor3 = format.COLOR_CLOSE,
        Text = "×",
        AutoButtonColor = false
    }

    tbl3[React.Event.Activated] = function()
        var2(false)
    end

    tbl2.Close = createElement2("TextButton", tbl3)
    return createElement("Frame", tbl1, tbl2)
end

return PopLatencyOverlay
