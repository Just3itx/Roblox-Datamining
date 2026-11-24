-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:21:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InGameAssetReporting = script:FindFirstAncestor("InGameAssetReporting")

local _Types = require(InGameAssetReporting.InGameAssetReportUI.Resources.Types)
local AnalyticsActions = require(InGameAssetReporting.InGameAssetReportUI.Resources.Constants).AnalyticsActions

local function analyticsReducer(arg1, arg2)
    local var1 = table.clone(arg1)
    local type = arg2.type

    if type == AnalyticsActions.SetPlaceId then
        var1.place_id = arg2.place_id
        return var1
    elseif type == AnalyticsActions.AccumulateForTimeSpent then
        var1.accumulated_time_ms = arg2.accumulated_time_ms
        return var1
    elseif type == AnalyticsActions.SetReasonSelection then
        var1.reason_selection = arg2.reason_selection
        return var1
    elseif type == AnalyticsActions.SetSurfaceSelection then
        var1.surface_selection = arg2.surface_selection
        return var1
    elseif type == AnalyticsActions.SetPrefilledSurfaceSelection then
        var1.prefilled_surface_selection = arg2.prefilled_surface_selection
        return var1
    elseif type == AnalyticsActions.SetCommentAdded then
        var1.comment_added = arg2.comment_added
        return var1
    elseif type == AnalyticsActions.IncrementNextCount then
        var1.next_count += 1
        return var1
    elseif type == AnalyticsActions.IncremementAnnotationCount then
        var1.annotation_place_count += 1
        return var1
    elseif type == AnalyticsActions.IncremementAnnotationUndoCount then
        var1.annotation_undo_count += 1
        return var1
    elseif type == AnalyticsActions.IncremementAnnotationRedoCount then
        var1.annotation_redo_count += 1
        return var1
    elseif type == AnalyticsActions.SetExtractionResults then
        local results = arg2.results

        var1.annotation_final_count = arg2.final_annotation_count
        var1.avatar_final_count = results.stats.playersCount
        var1.image_asset_count = #results.extractedAssets.Image
        var1.mesh_asset_count = #results.extractedAssets.Mesh
        var1.model_asset_count = #results.extractedAssets.Model
        var1.package_asset_count = #results.extractedAssets.Package
        var1.final_raycast_target_count = results.stats.raycastTargetCount
        var1.final_raycast_completed_count = results.stats.raycastCompletedCount
        var1.final_raycast_resumption_count = results.stats.raycastResumptionCount
        var1.final_raycast_computation_time_us = math.ceil(results.stats.raycastComputeTime * 1000000)
        var1.hit_count_map_size = results.stats.hitCountMapSize
        var1.top_level_objects_size = results.stats.topLevelObjectsSize
        var1.instances_traversed_count = results.stats.instancesTraversed
        var1.traversal_task_list_size = results.stats.traversalTaskListSize
        var1.traversal_tasks_completed_count = results.stats.traversalTasksCompleted
        var1.extraction_resumption_count = results.stats.resumptionCount
        var1.extraction_computation_time_us = math.ceil(results.stats.computeTime * 1000000)
        var1.extraction_wall_time_us = math.ceil(results.stats.wallTime * 1000000)
        return var1
    elseif type == AnalyticsActions.SetViewportInformation then
        var1.viewport_size_x = arg2.viewport_size_x
        var1.viewport_size_y = arg2.viewport_size_y
        var1.is_portrait_mode = arg2.is_portrait_mode
        return var1
    elseif type == AnalyticsActions.SetDidUserResize then
        var1.did_user_resize = arg2.did_user_resize
        return var1
    else
        if type == AnalyticsActions.SetVariant then
            var1.variant = arg2.variant
        end

        return var1
    end
end
return analyticsReducer
