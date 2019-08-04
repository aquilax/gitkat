project('gtkat', ['c', 'vala'],        version: '0.1.0',
  meson_version: '>= 0.40.0',
)

dependencies = [
    dependency('glib-2.0'),
    dependency('gobject-2.0'),
    dependency('gtk+-3.0'),
]

sources = files('src/app.vala')

executable('gitkat', sources, dependencies: dependencies)