-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:20:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local Object = require(scriptParentParentParentParent.LuauPolyfill).Object

local _core = require(script.Parent.Parent.Parent.core)

local React = require(scriptParentParentParentParent.React)
local useContext = React.useContext
local useState = React.useState
local useRef = React.useRef
local useEffect = React.useEffect
local _GraphQL = require(scriptParentParentParentParent.GraphQL)

local _typedDocumentNode = require(scriptParentParentParent.jsutils.typedDocumentNode)

local _types = require(script.Parent.Parent.types.types)

local MutationData = require(script.Parent.Parent.data).MutationData

local getApolloContext = require(script.Parent.Parent.context).getApolloContext

function module.useMutation(mutation, arg1)
    local context = useContext(getApolloContext())
    local var2, var3 = useState({ called = false, loading = false })
    local options = not arg1 and { mutation = mutation } or Object.assign({}, arg1, { mutation = mutation })

    local var5 = useRef(nil)

    local function getMutationDataRef()
        if not var5.current then
            var5.current = MutationData.new({
                options = options,
                context = context,
                result = var2,
                setResult = function(_, arg2)
                    var3(arg2)
                    return nil
                end
            })
        end

        return var5.current
    end

    local mutationDataRef = getMutationDataRef()
    mutationDataRef:setOptions(options)
    mutationDataRef.context = context

    useEffect(function()
        return mutationDataRef:afterExecute()
    end)

    return mutationDataRef:execute(var2)
end
return module
