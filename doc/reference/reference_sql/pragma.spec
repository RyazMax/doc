stack (
  line(
    ' PRAGMA ',
    'pragma-name',
    choice(
      None,
      line('=', 'pragma-value'),
      line('(', 'pragma-value', ')')
    )
  )
)
