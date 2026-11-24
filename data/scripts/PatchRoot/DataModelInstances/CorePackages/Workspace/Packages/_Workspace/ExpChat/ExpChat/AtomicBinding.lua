-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:30:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function parsePath(arg1): {string}
    local tbl1 = string.split(arg1, "/")
    for i = #tbl1, 1, -1 do
        if tbl1[i] == "" then
            table.remove(tbl1, i)
        end
    end
    return tbl1
end

local function isManifestResolved(arg1, _manifestSizeTarget): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local num1 = 0
    for _ in pairs(arg1) do
        num1 += 1
    end

    assert(num1 <= _manifestSizeTarget, num1)
    return num1 == _manifestSizeTarget
end

local function unbindNodeDescend(arg1, arg2)
    if arg1.instance == nil then
        return
    end

    arg1.instance = nil

    local connections = arg1.connections
    if connections then
        for _, connection in ipairs(connections) do
            connection:Disconnect()
        end
        table.clear(connections)
    end

    if arg2 and arg1.alias then
        arg2[arg1.alias] = nil
    end

    local children = arg1.children
    if not children then
        return
    end

    for _, child in pairs(children) do
        unbindNodeDescend(child, arg2)
    end
end

local module = {}
module.__index = module

function module.new(arg1, _boundFn)
    local _dtorMap = {}
    local _connections = {}
    local _rootInstToRootNode = {}
    local _rootInstToManifest = {}

    local _parsedManifest = ({})
    local num1 = 1

    for k, value in pairs(arg1) do
        _parsedManifest[k] = parsePath(value)
        num1 += 1
    end

    return (setmetatable({
        _boundFn = _boundFn,
        _parsedManifest = _parsedManifest,
        _manifestSizeTarget = num1,
        _dtorMap = _dtorMap,
        _connections = _connections,
        _rootInstToRootNode = _rootInstToRootNode,
        _rootInstToManifest = _rootInstToManifest
    }, module))
end

function module:_startBoundFn(arg1, arg2)
    local _boundFn = self._boundFn
    local _dtorMap = self._dtorMap

    local var1 = _dtorMap[arg1]
    if var1 then
        var1()
        _dtorMap[arg1] = nil
    end

    local var2 = _boundFn(arg2)
    if var2 then
        _dtorMap[arg1] = var2
    end
end

function module:_stopBoundFn(arg1)
    local _dtorMap = self._dtorMap

    local var1 = _dtorMap[arg1]
    if var1 then
        var1()
        _dtorMap[arg1] = nil
    end
end

function module:bindRoot(instance)
    debug.profilebegin("AtomicBinding:BindRoot")

    local _parsedManifest = self._parsedManifest
    local _rootInstToRootNode = self._rootInstToRootNode
    local _rootInstToManifest = self._rootInstToManifest
    local _manifestSizeTarget = self._manifestSizeTarget

    if _rootInstToManifest[instance] ~= nil then
        return
    end

    local tbl1 = ({})
    _rootInstToManifest[instance] = tbl1

    debug.profilebegin("BuildTree")

    local tbl2 = { alias = "root", instance = instance }
    if next(_parsedManifest) then
        tbl2.children = {}
        tbl2.connections = {}
    end

    _rootInstToRootNode[instance] = tbl2

    for alias, value in pairs(_parsedManifest) do
        local tbl3 = tbl2

        for i, value2 in ipairs(value) do
            local bool1 = i == #value
            local child = tbl2.children[value2] or {}

            if bool1 then
                if child.alias ~= nil then
                    error("Multiple aliases assigned to one instance")
                end

                child.alias = alias
            else
                child.children = child.children or {}
                child.connections = child.connections or {}
            end

            tbl2.children[value2] = child
            tbl2 = child
        end

        tbl2 = tbl3
    end

    debug.profileend()

    local function processNode(arg1)
        local var1 = assert(arg1.instance, "instance does not exist")

        local children = arg1.children
        local alias = arg1.alias
        local bool1 = not children

        if alias then
            tbl1[alias] = var1
        end

        if not bool1 then
            local function processAddChild(instance2) -- Luacid: Inlined by compiler; 1 call site recovered
                local instance2Name = instance2.Name
                local child = children[instance2Name]
                if not child or child.instance ~= nil then
                    return
                end

                child.instance = instance2
                processNode(child)
            end

            local function processDeleteChild(child: Instance)
                local childName = child.Name
                local child2 = children[childName]

                if not child2 or child2.instance ~= child then
                    return
                end

                self:_stopBoundFn(instance)
                unbindNodeDescend(child2, tbl1)

                assert(child2.instance == nil, "unbindNodeDescend failed")

                local var2 = var1:FindFirstChild(childName)
                if var2 then
                    processAddChild(var2)
                end
            end

            for _, child in ipairs(var1:GetChildren()) do
                local child2 = children[child.Name]
                if child2 and child2.instance == nil then
                    child2.instance = child
                    processNode(child2)
                end
            end

            table.insert(arg1.connections, var1.ChildAdded:Connect(processAddChild))
            table.insert(arg1.connections, var1.ChildRemoved:Connect(processDeleteChild))
        end

        if bool1 and isManifestResolved(tbl1, _manifestSizeTarget) then
            self:_startBoundFn(instance, tbl1)
        end
    end

    debug.profilebegin("ResolveTree")
    processNode(tbl2)
    debug.profileend()

    debug.profileend()
end

function module:unbindRoot(arg1)
    local _rootInstToRootNode = self._rootInstToRootNode
    local _rootInstToManifest = self._rootInstToManifest

    self:_stopBoundFn(arg1)

    local var1 = _rootInstToRootNode[arg1]
    if var1 then
        local var2 = assert(_rootInstToManifest[arg1], "rootInstToManifest is nil")
        unbindNodeDescend(var1, var2)
        _rootInstToRootNode[arg1] = nil
    end

    _rootInstToManifest[arg1] = nil
end

function module:destroy()
    debug.profilebegin("AtomicBinding:destroy")

    for _, value in pairs(self._dtorMap) do
        value:destroy()
    end
    table.clear(self._dtorMap)

    for _, _connection in ipairs(self._connections) do
        _connection:Disconnect()
    end
    table.clear(self._connections)

    local _rootInstToManifest = self._rootInstToManifest
    for k, value in pairs(self._rootInstToRootNode) do
        local var1 = assert(_rootInstToManifest[k], "rootInstToManifest is nil")
        unbindNodeDescend(value, var1)
    end
    table.clear(self._rootInstToManifest)
    table.clear(self._rootInstToRootNode)

    debug.profileend()
end

return module
