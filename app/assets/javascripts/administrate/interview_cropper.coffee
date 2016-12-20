jQuery ->
  new InterviewCropper()

class InterviewCropper
  constructor: ->
    $('#cropbox').Jcrop {
      applyFilters: ['constrain', 'extent', 'backoff', 'ratio', 'round']
      aspectRatio: 1
      setSelect: [0, 0, 166, 166]
      handles: ['n', 's', 'e', 'w']
      borders: []
      onSelect: @update
      onChange: @update
    }, ->
      jcrop_api = this
      new ($.Jcrop.component.Thumbnailer)(jcrop_api,
        width: 166
        height: 166
        autoHide: true
      )

  update: (coords) =>
    $('#interview_crop_x').val(coords.x)
    $('#interview_crop_y').val(coords.y)
    $('#interview_crop_w').val(coords.w)
    $('#interview_crop_h').val(coords.h)
