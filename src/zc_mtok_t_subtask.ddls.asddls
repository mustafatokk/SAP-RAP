@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection: Subtask'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_MTOK_T_SUBTASK as projection on ZI_MTOK_T_SUBTASK
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
    /* Associations */
    _parent : redirected to parent ZC_MTOK_T_TASK
}
