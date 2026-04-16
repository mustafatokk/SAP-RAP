@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Composite : Subtask'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZI_MTOK_T_SUBTASK as select from ZR_MTOK_T_SUBTASK
association to parent ZI_MTOK_T_TASK as _parent
    on $projection.TaskID = _parent.TaskID
{
    key TaskID,
    key SubtaskID,
    Description,
    Status,
    Priority,
    DueDate,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    LocalLastChangedAt,
    _parent // Make association public
}
