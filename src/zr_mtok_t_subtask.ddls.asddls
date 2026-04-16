@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Subtasks Base View'
@Metadata.ignorePropagatedAnnotations: true
@AbapCatalog.sqlViewName: 'ZRMTOKV_SUBTASK'
@Metadata.allowExtensions: true
define root view ZR_MTOK_T_SUBTASK as select from zmtok_t_subtask

{
    key task_id as TaskID,
    key subtask_id as SubtaskID,
    description as Description,
    status as Status,
    priority as Priority,
    due_date as DueDate,
    created_by as CreatedBy,
    created_at as CreatedAt,
    last_changed_by as LastChangedBy,
    last_changed_at as LastChangedAt,
    local_last_changed_at as LocalLastChangedAt
    
}
