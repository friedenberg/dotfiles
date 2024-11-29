#! /usr/bin/env -S jq -f

def make_id:
  [
    "",
    (
      [
        .id.browser.browser,
        .id.browser.id
      ] | join("-")
    ),
    (
      [
        .id.type,
        .id.id
      ] | join("-")
    )
  ] | join("/")
  ;

{
  items: [
    .[]
    | {
      title: .title,
      subtitle: (
        (. | make_id) + ": " + .url.string
      ),
      arg: (. | @json),
      uid: (. | make_id),
      match: (
        (.url.parts.Host | split(".")) +
        (.url.parts.Path | split("/")) + [
          .id.browser.browser,
          .id.browser.id,
          .id.type,
          .id.id,
          .title,
          .url.string
        ] | join(" ")
      )
    }
  ]
}
