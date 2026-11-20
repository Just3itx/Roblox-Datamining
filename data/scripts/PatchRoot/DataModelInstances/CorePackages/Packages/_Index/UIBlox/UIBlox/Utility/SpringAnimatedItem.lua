-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local Otter = require(scriptParentParentParent.Otter)
local Roact = require(scriptParentParentParent.Roact)
local Cryo = require(scriptParentParentParent.Cryo)
local t = require(scriptParentParentParent.t)

local var1 = t.intersection(
    t.strictInterface({
        animatedValues = t.table,
        mapValuesToProps = t.callback,
        springOptions = t.optional(t.table),
        onComplete = t.optional(t.callback),
        regularProps = t.table,
        [Roact.Children] = t.optional(t.table)
    }),
    function(arg1)
        if arg1[Roact.Children] ~= nil and arg1.regularProps[Roact.Children] ~= nil then
            return false, "Children must be specified in one place, but the [Roact.Children] key was found in both props and props.regularProps on SpringAnimatedItem."
        end

        return true
    end
)

local module = {}

function module.wrap(arg1)
    local var2 = Roact.PureComponent:extend(string.format("SpringAnimatedItem(%s)", tostring(arg1)))

    var2.defaultProps = {
        regularProps = {}
    }

    function var2.init(arg2)
        arg2.ref = arg2.props.regularProps[Roact.Ref] or Roact.createRef()

        function arg2.applyAnimatedValues(arg3)
            local current = arg2.ref.current
            if current == nil then
                return
            end

            local var3 = arg2.props.mapValuesToProps(arg3)
            for k, value in pairs(var3) do
                current[k] = value
            end
        end

        function arg2.onComplete()
            if arg2.props.onComplete then
                arg2.props.onComplete()
            end
        end

        arg2.motor = nil
    end

    function var2.didMount(arg2)
        local animatedValues = arg2.props.animatedValues

        arg2.applyAnimatedValues(animatedValues)

        arg2.motor = Otter.createGroupMotor(animatedValues)
        arg2.motor:onStep(function(arg3)
            arg2.applyAnimatedValues(arg3)
        end)
        arg2.motor:onComplete(arg2.onComplete)
        arg2.motor:start()
    end

    function var2.willUpdate(arg2, arg3)
        if arg2.props.regularProps[Roact.Ref] ~= arg3.regularProps[Roact.Ref] and arg3.regularProps[Roact.Ref] ~= nil then
            arg2.ref = arg3.regularProps[Roact.Ref]
        end
    end

    function var2.render(arg2)
        assert(var1(arg2.props))

        local regularProps = arg2.props.regularProps
        local var3 = Cryo.Dictionary.join(regularProps, { [Roact.Ref] = arg2.ref, [Roact.Children] = arg2.props[Roact.Children] })

        return Roact.createElement(arg1, var3)
    end

    function var2.didUpdate(arg2, arg3)
        if arg2.props.animatedValues == arg3.animatedValues then
            return
        end

        local tbl1 = ({})
        local bool1 = false
        for k, value in pairs(arg2.props.animatedValues) do
            local springOptions = arg2.props.springOptions
            tbl1[k] = Otter.spring(value, springOptions)
            if value ~= arg3.animatedValues[k] then
                bool1 = true
            end
        end

        if bool1 then
            arg2.motor:setGoal(tbl1)
        end
    end

    function var2.willUnmount(arg2)
        if arg2.motor then
            arg2.motor:destroy()
            arg2.motor = nil
        end
    end

    return var2
end

module.AnimatedFrame = module.wrap("Frame")
module.AnimatedScrollingFrame = module.wrap("ScrollingFrame")
module.AnimatedImageLabel = module.wrap("ImageLabel")
module.AnimatedTextButton = module.wrap("TextButton")
module.AnimatedUIScale = module.wrap("UIScale")

return module
