## Mokio History

### Internal models
Mokio::Content are using History out of the box. You do not have to do anything.

### External models:
Include History module:
```
include Mokio::Concerns::Common::History::Model
```

### External controllers:
Include History module:
```
include Mokio::Concerns::Common::History::Controller
```

Use history_mark method on your object for support current user tracking
```
def update
  history_mark(obj)
  ...
end
```

### External inputs values:
Customize the output string in backend for external inputs

For example:

history_mark_column_name

```
# value - string
def history_mark_subtitle(value)
  ..You can customize the subtitle output here..
end
```

### External inputs labels:

You can customize translations for external inputs in yml.
This translations be displayed in table history view.

```
en:
  contents:
    subtitle: Subtitle
```

Or override the history label helper method:

```
# object - Mokio::History
# object.field - input name - string

def history_helper_label(object)
  object.field
  ..You can customize the output here..
end
```
### Additional configuration options

#### Model methods

Enable/disable historable

```
historable_enabled?
```

Show/Hide historable

```
historable_displayed?
```
