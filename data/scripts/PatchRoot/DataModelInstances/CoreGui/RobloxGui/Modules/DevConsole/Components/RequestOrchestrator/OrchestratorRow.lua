-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:40:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)

local Constants = require(script.Parent.Parent.Parent.Constants)
local Mono = Constants.Font.Mono

local tbl1 = {
    inflight = Color3.fromRGB(255, 165, 0),
    retrying = Color3.fromRGB(255, 165, 0),
    success = Color3.fromRGB(66, 135, 245),
    failure = Color3.fromRGB(220, 50, 50),
    exhausted = Color3.fromRGB(220, 50, 50),
    queueOp = Color3.fromRGB(0, 149, 235),
    queueRetry = Color3.fromRGB(239, 68, 68),
    batchOutline = Color3.fromRGB(255, 171, 37),
    labelText = Color3.fromRGB(200, 200, 200),
    queueText = Color3.fromRGB(160, 160, 160),
    cacheHot = Color3.fromRGB(100, 255, 180),
    cacheCold = Color3.fromRGB(60, 120, 95),
    cacheEmpty = Constants.Color.BaseGray,
    idleText = Color3.fromRGB(70, 70, 70),
    timelineTick = Color3.fromRGB(50, 50, 50),
    timelineBackground = Color3.fromRGB(20, 20, 20),
    rowBackground = Color3.fromRGB(28, 28, 28)
}

local function lerp(fromX, toX, num1: number) -- Luacid: Inlined by compiler; 2 call sites recovered
    return fromX + (toX - fromX) * num1
end

local function smooth(num1: number): number -- Luacid: Inlined by compiler; 2 call sites recovered
    return num1 * num1 * (3 - 2 * num1)
end

local function renderTypeLabel(text)
    return Roact.createElement("TextLabel", {
        Size = UDim2.new(0, 130, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = tbl1.labelText,
        TextSize = 12,
        Font = Mono,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top
    })
end

local function resolveMaxSize(props) -- Luacid: Inlined by compiler; 1 call site recovered
    local observedMaxBatchSize = props.observedMaxBatchSize
    return if observedMaxBatchSize and observedMaxBatchSize > 0 then observedMaxBatchSize else nil
end

local function renderBatchOutline(props, arg1)
    local num1 = math.min(arg1, 30)
    local panelWidth = props.panelWidth
    if panelWidth and panelWidth > 0 then
        num1 = math.min(num1, math.floor((panelWidth - 374 - 8 - 8 + 3) / 19))
    end
    local num2 = math.max(1, num1)
    local bool1 = num2 < arg1

    local xOffset = num2 * 16 + math.max(0, num2 - 1) * 3 + 8

    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = UDim2.new(0, xOffset, 0, 21),
        Position = UDim2.new(0, 374, 0, 1.5),
        BackgroundTransparency = 1,
        BorderSizePixel = 0
    }

    local tbl3 = {
        Corner = Roact.createElement("UICorner", { CornerRadius = UDim.new(0, 4) }),
        Stroke = Roact.createElement("UIStroke", { Color = tbl1.batchOutline, Thickness = 1.5, Transparency = 0.15 }),
        Overflow = 0
    }
    local element

    if bool1 then
        element = Roact.createElement("TextLabel", {
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, -2, 0.5, 0),
            Size = UDim2.new(0, 10, 1, 0),
            BackgroundTransparency = 1,
            Text = "»",
            TextColor3 = tbl1.batchOutline,
            TextSize = 12,
            Font = Mono,
            TextXAlignment = Enum.TextXAlignment.Right,
            TextYAlignment = Enum.TextYAlignment.Center
        })
    else
        element = nil
    end

    tbl3.Overflow = element
    return createElement(str1, tbl2, tbl3)
end

local function renderIdleQueue()
    return Roact.createElement("TextLabel", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = "idle",
        TextColor3 = tbl1.idleText,
        TextSize = 10,
        Font = Mono,
        TextXAlignment = Enum.TextXAlignment.Left
    })
end

local function renderCacheChildren(cache, now)
    local result = {}
    local var1 = not cache and {} or cache.items
    local num1 = #var1

    result.Count = Roact.createElement("TextLabel", {
        Size = UDim2.new(1, 0, 0, 12),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = string.format("cache %d", num1),
        TextColor3 = tbl1.queueText,
        TextSize = 10,
        Font = Mono,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    for i, value in ipairs(var1) do
        if i > 48 then
            break
        end

        local var2 = (i - 1) % 12
        local num2 = math.floor((i - 1) / 12)
        local alpha = if value.lastHitTime then math.clamp(1 - (now - value.lastHitTime) / 0.6, 0, 1) else 0
        local var3 = "c" .. i
        local createElement = Roact.createElement
        local tbl2 = {
            Position = UDim2.new(0, var2 * 10, 0, num2 * 10 + 12),
            Size = UDim2.new(0, 8, 0, 8),
            BackgroundColor3 = tbl1.cacheCold:Lerp(tbl1.cacheHot, alpha),
            BorderSizePixel = 0
        }
        local tbl3 = {
            Corner = Roact.createElement("UICorner", { CornerRadius = UDim.new(0, 2) })
        }
        result[var3] = createElement("Frame", tbl2, tbl3)
    end

    for i = num1 + 1, 48 do
        local num2 = (i - 1) % 12
        local num3 = math.floor((i - 1) / 12)
        local str1 = "e" .. i
        local createElement = Roact.createElement
        local tbl2 = {
            Position = UDim2.new(0, num2 * 10, 0, num3 * 10 + 12),
            Size = UDim2.new(0, 8, 0, 8),
            BackgroundColor3 = tbl1.cacheEmpty,
            BorderSizePixel = 0
        }
        local tbl3 = {
            Corner = Roact.createElement("UICorner", { CornerRadius = UDim.new(0, 2) })
        }
        result[str1] = createElement("Frame", tbl2, tbl3)
    end

    return result
end

local function renderTimelineChildren(batches, now)
    local var1 = now - 30
    local result = ({})

    for k, value in pairs(batches) do
        local var2 = value.attempts or {}
        local num1 = #var2
        for i, value2 in ipairs(var2) do
            local var3 = value2.finish or now

            if not (var1 <= var3) then
                continue
            end

            local xScale = math.max(0, (value2.start - var1) / 30)
            local num2 = math.min(1, (var3 - var1) / 30)
            if not (xScale < num2) then
                continue
            end

            local backgroundColor3 = if i == num1 then tbl1[value.state] or tbl1.inflight else tbl1.retrying
            local var5 = "batch_" .. k .. "_" .. i
            local createElement = Roact.createElement
            local tbl2 = {
                Position = UDim2.new(xScale, 0, 0, 2),
                Size = UDim2.new(num2 - xScale, 0, 1, -4),
                BackgroundColor3 = backgroundColor3,
                BorderSizePixel = 0
            }
            local tbl3 = {
                Corner = Roact.createElement("UICorner", { CornerRadius = UDim.new(0, 4) })
            }
            result[var5] = createElement("Frame", tbl2, tbl3)
        end
    end

    for i = 0, 2 do
        local xScale = 1 - i * 10 / 30
        local str1 = "tick_" .. i
        result[str1] = Roact.createElement("Frame", {
            Position = UDim2.new(xScale, 0, 0, 0),
            Size = UDim2.new(0, 1, 1, 0),
            BackgroundColor3 = tbl1.timelineTick,
            BorderSizePixel = 0
        })
    end

    return result
end

local var1 = Roact.Component:extend("OrchestratorRow")

function var1.init(arg1)
    arg1.opAnim = {}
end

function var1.renderQueueChildren(arg1, arg2, arg3, start)
    local result = {}

    local tbl2 = {}
    for _, id in ipairs(arg2.retryOps or {}) do
        table.insert(tbl2, { id = id, isRetry = true })
    end
    for _, id in ipairs(arg2.ops or {}) do
        table.insert(tbl2, { id = id, isRetry = false })
    end

    local var2 = start - arg2.createdTime
    local num1 = #tbl2

    result.Info = Roact.createElement("TextLabel", {
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(0, 120, 1, 0),
        BackgroundTransparency = 1,
        Text = if arg3 then string.format("%d/%d ops  %.1fs", num1, arg3, var2) else string.format("%d ops  %.1fs", num1, var2),
        TextColor3 = tbl1.queueText,
        TextSize = 10,
        Font = Mono,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    local tbl3 = ({})
    for i, value in ipairs(tbl2) do
        if i > 30 then
            break
        end

        local id = value.id
        if tbl3[id] then
            id ..= "#" .. i
        end
        tbl3[id] = true

        local var3 = 120 + (i - 1) * 19
        local tbl4 = arg1.opAnim[id]
        if not tbl4 then
            tbl4 = {
                fromX = if value.isRetry then var3 - 19 else var3,
                toX = var3,
                start = start
            }
            arg1.opAnim[id] = tbl4
        elseif tbl4.toX ~= var3 then
            local fromX = tbl4.fromX
            local toX = tbl4.toX
            local var4 = (start - tbl4.start) / 0.25
            tbl4.fromX = lerp(fromX, toX, (smooth(math.clamp(var4, 0, 1))))
            tbl4.toX = var3
            tbl4.start = start
        end

        local fromX = tbl4.fromX
        local toX = tbl4.toX
        local var4 = (start - tbl4.start) / 0.25
        local xOffset = lerp(fromX, toX, (smooth(math.clamp(var4, 0, 1))))

        local queueOp = tbl1.queueOp
        local var5

        if value.isRetry then
            queueOp = tbl1.queueRetry
            var5 = (math.sin(start * 7) * 0.5 + 0.5) * 0.75
        else
            var5 = 0
        end

        local var6 = "op_" .. id
        local createElement = Roact.createElement
        local tbl5 = {
            Position = UDim2.new(0, xOffset, 0.5, -8),
            Size = UDim2.new(0, 16, 0, 16),
            BackgroundColor3 = queueOp,
            BackgroundTransparency = var5,
            BorderSizePixel = 0
        }
        local tbl6 = {
            Corner = Roact.createElement("UICorner", { CornerRadius = UDim.new(0, 3) })
        }
        result[var6] = createElement("Frame", tbl5, tbl6)
    end

    for k in pairs(arg1.opAnim) do
        if not tbl3[k] then
            arg1.opAnim[k] = nil
        end
    end

    return result
end

function var1.render(arg1)
    local orchestratorType = arg1.props.orchestratorType
    local batches = arg1.props.batches
    local queue = arg1.props.queue
    local now = arg1.props.now
    local size = arg1.props.size
    local layoutOrder = arg1.props.layoutOrder

    local tbl2 = {
        Label = renderTypeLabel(orchestratorType),
        CacheGrid = Roact.createElement("Frame", {
            Size = UDim2.new(0, 120, 1, 0),
            Position = UDim2.new(0, 134, 0, 0),
            BackgroundTransparency = 1,
            ClipsDescendants = true
        }, (renderCacheChildren(arg1.props.cache, now)))
    }
    local var2 = resolveMaxSize(arg1.props)
    if var2 then
        tbl2.BatchOutline = renderBatchOutline(arg1.props, var2)
    end

    local tbl3

    if queue then
        tbl3 = arg1:renderQueueChildren(queue, var2, now)
    else
        arg1.opAnim = {}
        tbl3 = {
            Idle = renderIdleQueue()
        }
    end

    tbl2.Queue = Roact.createElement("Frame", {
        Size = UDim2.new(1, -258, 0, 24),
        Position = UDim2.new(0, 258, 0, 0),
        BackgroundTransparency = 1,
        ClipsDescendants = true
    }, tbl3)

    tbl2.Timeline = Roact.createElement("Frame", {
        Size = UDim2.new(1, -258, 0, 28),
        Position = UDim2.new(0, 258, 0, 24),
        BackgroundColor3 = tbl1.timelineBackground,
        BorderSizePixel = 0,
        ClipsDescendants = true
    }, (renderTimelineChildren(batches, now)))

    return Roact.createElement(
        "Frame",
        {
            Size = size,
            BackgroundColor3 = tbl1.rowBackground,
            BorderSizePixel = 0,
            LayoutOrder = layoutOrder
        },
        tbl2
    )
end

return var1
