-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:21:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)

local _UserPickerTypes = require(script.Parent.UserPickerTypes)

local num1 = game:DefineFastInt("BuildExperienceUserPickerSearchDebounceMs", 250)

local function trim(str1: string) -- Luacid: Inlined by compiler; 4 call sites recovered
    return (string.gsub(str1, "^%s*(.-)%s*$", "%1"))
end

local function countKeys(tbl1): number -- Luacid: Inlined by compiler; 4 call sites recovered
    local num2 = 0
    for _, value in tbl1 do
        if value then
            num2 += 1
        end
    end
    return num2
end

local function appendUniqueIds(tbl1, ids)
    local tbl2 = ({})
    for _, value in tbl1 do
        tbl2[value] = true
    end
    local var1 = table.clone(tbl1)
    for _, value in ids do
        if not tbl2[value] then
            table.insert(var1, value)
        end
    end
    return var1
end

local function useUserPicker(arg1)
    local browseIds = arg1.browseIds
    local browseIsLoading = arg1.browseIsLoading
    local loadMoreBrowse = arg1.loadMoreBrowse
    local onSearch = arg1.onSearch
    local onSubmit = arg1.onSubmit
    local selectionLimit = arg1.selectionLimit
    local onSelectionChanged = arg1.onSelectionChanged
    local excludeUserIds = arg1.excludeUserIds

    local searchText, setSearchText = React.useState("")
    local var3, var4 = React.useState({})

    local var5, var6 = React.useState(nil)
    local var7, var8 = React.useState(false)
    local var9, var10 = React.useState({})
    local message, setMessage = React.useState("")
    local isSubmitting, var14 = React.useState(false)

    local var15 = React.useRef(false)
    local var16 = React.useRef(0)
    local var17 = React.useRef(false)
    local bool1 = trim(searchText) ~= ""

    React.useEffect(function()
        local var18 = trim(searchText)
        if var18 == "" then
            var4({})
            var6(nil)
            var8(false)
            return
        end

        local var19 = var16
        var19.current += 1
        local current = var16.current

        var4({})
        var6(nil)
        var8(true)
        local var20 = task.delay(num1 / 1000, function()
            onSearch(var18):andThen(function(arg2)
                if var16.current == current then
                    var4(arg2.ids)
                    var6(arg2.nextCursor)
                    var8(false)
                end
            end):catch(function()
                if var16.current == current then
                    var4({})
                    var6(nil)
                    var8(false)
                end
            end)
        end)

        return function()
            pcall(task.cancel, var20)
        end
    end, { searchText, onSearch })

    local loadMore = React.useCallback(function()
        if not bool1 then
            loadMoreBrowse()
            return
        end

        if var15.current or var5 == nil then
            return
        end
        var15.current = true
        local current = var16.current

        onSearch(trim(searchText), var5):andThen(function(arg2)
            if var16.current ~= current then
                return
            end
            var4(function(arg3)
                return (appendUniqueIds(arg3, arg2.ids))
            end)
            var6(arg2.nextCursor)
        end):finally(function()
            var15.current = false
        end)
    end, {
        bool1,
        var5,
        searchText,
        onSearch,
        loadMoreBrowse
    })
    local userIds = React.useMemo(function()
        local var19 = if bool1 then var3 else browseIds

        if excludeUserIds == nil then
            return var19
        end
        local result = {}
        for _, value in var19 do
            if not excludeUserIds[value] then
                table.insert(result, value)
            end
        end
        return result
    end, {
        bool1,
        var3,
        browseIds,
        excludeUserIds
    })

    local selectedCount = countKeys(var9)

    React.useEffect(function()
        if selectionLimit == nil then
            return
        end
        local var20 = selectionLimit
        var10(function(arg2)
            if countKeys(arg2) <= var20 then
                return arg2
            end
            local result = ({})
            local num3 = 0
            for value, value2 in arg2 do
                if value2 and num3 < var20 then
                    result[value] = true
                    num3 += 1
                end
            end
            return result
        end)
    end, { selectionLimit })

    React.useEffect(function()
        if not var17.current then
            var17.current = true
            return
        end
        if onSelectionChanged == nil then
            return
        end

        local tbl1 = {}
        for value, value2 in var9 do
            if value2 then
                table.insert(tbl1, value)
            end
        end
        onSelectionChanged(tbl1)
    end, { var9, onSelectionChanged })

    local isSelected = React.useCallback(function(num3: number): boolean
        return var9[num3] == true
    end, { var9 })

    local canSelect = React.useCallback(function(num3: number): boolean
        return var9[num3] == true or selectionLimit == nil or countKeys(var9) < selectionLimit
    end, { var9, selectionLimit })

    local toggleSelected = React.useCallback(function(num3: number)
        var10(function(arg2)
            local var22 = table.clone(arg2)
            if var22[num3] then
                var22[num3] = nil
                return var22
            end

            if selectionLimit ~= nil and not (countKeys(var22) < selectionLimit) then
                return arg2
            end

            var22[num3] = true
            return var22
        end)
    end, { selectionLimit })

    local submit = React.useCallback(function()
        if isSubmitting then
            return
        end
        local tbl1 = {}
        for value, value2 in var9 do
            if value2 then
                table.insert(tbl1, value)
            end
        end
        if #tbl1 == 0 then
            return
        end
        var14(true)
        local var23 = onSubmit
        local var24 = if trim(message) == "" then nil else message

        var23(tbl1, var24):finally(function()
            var14(false)
        end)
    end, {
        isSubmitting,
        var9,
        message,
        onSubmit
    })
    local tbl1 = {
        searchText = searchText,
        setSearchText = setSearchText,
        userIds = userIds,
        isLoading = 0,
        loadMore = 0,
        selectedCount = 0,
        hasSelection = 0,
        selectionLimit = 0,
        isSelected = 0,
        canSelect = 0,
        toggleSelected = 0,
        message = 0,
        setMessage = 0,
        isSubmitting = 0,
        submit = 0
    }
    if bool1 then
        browseIsLoading = var7
    end

    tbl1.isLoading = browseIsLoading
    tbl1.loadMore = loadMore
    tbl1.selectedCount = selectedCount
    tbl1.hasSelection = selectedCount > 0
    tbl1.selectionLimit = selectionLimit
    tbl1.isSelected = isSelected
    tbl1.canSelect = canSelect
    tbl1.toggleSelected = toggleSelected
    tbl1.message = message
    tbl1.setMessage = setMessage
    tbl1.isSubmitting = isSubmitting
    tbl1.submit = submit
    return tbl1
end

return useUserPicker
