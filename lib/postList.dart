// // To parse this JSON data, do
// //
// //     final postList = postListFromJson(jsonString);

// import 'dart:convert';

// List<PostList> postListFromJson(String str) =>
//     List<PostList>.from(json.decode(str).map((x) => PostList.fromJson(x)));

// String postListToJson(List<PostList> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class PostList {
//   PostList({
//     this.id,
//     this.date,
//     this.dateGmt,
//     this.guid,
//     this.modified,
//     this.modifiedGmt,
//     this.slug,
//     this.status,
//     this.type,
//     this.link,
//     this.title,
//     this.content,
//     this.excerpt,
//     this.author,
//     this.featuredMedia,
//     this.commentStatus,
//     this.pingStatus,
//     this.sticky,
//     this.template,
//     this.format,
//     this.meta,
//     this.categories,
//     this.tags,
//     this.yoastHead,
//     this.links,
//   });

//   int id;
//   DateTime date;
//   DateTime dateGmt;
//   Guid guid;
//   DateTime modified;
//   DateTime modifiedGmt;
//   String slug;
//   String status;
//   String type;
//   String link;
//   Guid title;
//   Content content;
//   Content excerpt;
//   int author;
//   int featuredMedia;
//   String commentStatus;
//   String pingStatus;
//   bool sticky;
//   String template;
//   String format;
//   List<dynamic> meta;
//   List<int> categories;
//   List<dynamic> tags;
//   String yoastHead;
//   Links links;

//   factory PostList.fromJson(Map<String, dynamic> json) => PostList(
//         id: json["id"],
//         date: DateTime.parse(json["date"]),
//         dateGmt: DateTime.parse(json["date_gmt"]),
//         guid: Guid.fromJson(json["guid"]),
//         modified: DateTime.parse(json["modified"]),
//         modifiedGmt: DateTime.parse(json["modified_gmt"]),
//         slug: json["slug"],
//         status: json["status"],
//         type: json["type"],
//         link: json["link"],
//         title: Guid.fromJson(json["title"]),
//         content: Content.fromJson(json["content"]),
//         excerpt: Content.fromJson(json["excerpt"]),
//         author: json["author"],
//         featuredMedia: json["featured_media"],
//         commentStatus: json["comment_status"],
//         pingStatus: json["ping_status"],
//         sticky: json["sticky"],
//         template: json["template"],
//         format: json["format"],
//         meta: List<dynamic>.from(json["meta"].map((x) => x)),
//         categories: List<int>.from(json["categories"].map((x) => x)),
//         tags: List<dynamic>.from(json["tags"].map((x) => x)),
//         yoastHead: json["yoast_head"],
//         links: Links.fromJson(json["_links"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "date": date.toIso8601String(),
//         "date_gmt": dateGmt.toIso8601String(),
//         "guid": guid.toJson(),
//         "modified": modified.toIso8601String(),
//         "modified_gmt": modifiedGmt.toIso8601String(),
//         "slug": slug,
//         "status": status,
//         "type": type,
//         "link": link,
//         "title": title.toJson(),
//         "content": content.toJson(),
//         "excerpt": excerpt.toJson(),
//         "author": author,
//         "featured_media": featuredMedia,
//         "comment_status": commentStatus,
//         "ping_status": pingStatus,
//         "sticky": sticky,
//         "template": template,
//         "format": format,
//         "meta": List<dynamic>.from(meta.map((x) => x)),
//         "categories": List<dynamic>.from(categories.map((x) => x)),
//         "tags": List<dynamic>.from(tags.map((x) => x)),
//         "yoast_head": yoastHead,
//         "_links": links.toJson(),
//       };
// }

// class Content {
//   Content({
//     this.rendered,
//     this.protected,
//   });

//   String rendered;
//   bool protected;

//   factory Content.fromJson(Map<String, dynamic> json) => Content(
//         rendered: json["rendered"],
//         protected: json["protected"],
//       );

//   Map<String, dynamic> toJson() => {
//         "rendered": rendered,
//         "protected": protected,
//       };
// }

// class Guid {
//   Guid({
//     this.rendered,
//   });

//   String rendered;

//   factory Guid.fromJson(Map<String, dynamic> json) => Guid(
//         rendered: json["rendered"],
//       );

//   Map<String, dynamic> toJson() => {
//         "rendered": rendered,
//       };
// }

// class Links {
//   Links({
//     this.self,
//     this.collection,
//     this.about,
//     this.author,
//     this.replies,
//     this.versionHistory,
//     this.predecessorVersion,
//     this.wpAttachment,
//     this.wpTerm,
//     this.curies,
//   });

//   List<About> self;
//   List<About> collection;
//   List<About> about;
//   List<Author> author;
//   List<Author> replies;
//   List<VersionHistory> versionHistory;
//   List<PredecessorVersion> predecessorVersion;
//   List<About> wpAttachment;
//   List<WpTerm> wpTerm;
//   List<Cury> curies;

//   factory Links.fromJson(Map<String, dynamic> json) => Links(
//         self: List<About>.from(json["self"].map((x) => About.fromJson(x))),
//         collection:
//             List<About>.from(json["collection"].map((x) => About.fromJson(x))),
//         about: List<About>.from(json["about"].map((x) => About.fromJson(x))),
//         author:
//             List<Author>.from(json["author"].map((x) => Author.fromJson(x))),
//         replies:
//             List<Author>.from(json["replies"].map((x) => Author.fromJson(x))),
//         versionHistory: List<VersionHistory>.from(
//             json["version-history"].map((x) => VersionHistory.fromJson(x))),
//         predecessorVersion: List<PredecessorVersion>.from(
//             json["predecessor-version"]
//                 .map((x) => PredecessorVersion.fromJson(x))),
//         wpAttachment: List<About>.from(
//             json["wp:attachment"].map((x) => About.fromJson(x))),
//         wpTerm:
//             List<WpTerm>.from(json["wp:term"].map((x) => WpTerm.fromJson(x))),
//         curies: List<Cury>.from(json["curies"].map((x) => Cury.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "self": List<dynamic>.from(self.map((x) => x.toJson())),
//         "collection": List<dynamic>.from(collection.map((x) => x.toJson())),
//         "about": List<dynamic>.from(about.map((x) => x.toJson())),
//         "author": List<dynamic>.from(author.map((x) => x.toJson())),
//         "replies": List<dynamic>.from(replies.map((x) => x.toJson())),
//         "version-history":
//             List<dynamic>.from(versionHistory.map((x) => x.toJson())),
//         "predecessor-version":
//             List<dynamic>.from(predecessorVersion.map((x) => x.toJson())),
//         "wp:attachment":
//             List<dynamic>.from(wpAttachment.map((x) => x.toJson())),
//         "wp:term": List<dynamic>.from(wpTerm.map((x) => x.toJson())),
//         "curies": List<dynamic>.from(curies.map((x) => x.toJson())),
//       };
// }

// class About {
//   About({
//     this.href,
//   });

//   String href;

//   factory About.fromJson(Map<String, dynamic> json) => About(
//         href: json["href"],
//       );

//   Map<String, dynamic> toJson() => {
//         "href": href,
//       };
// }

// class Author {
//   Author({
//     this.embeddable,
//     this.href,
//   });

//   bool embeddable;
//   String href;

//   factory Author.fromJson(Map<String, dynamic> json) => Author(
//         embeddable: json["embeddable"],
//         href: json["href"],
//       );

//   Map<String, dynamic> toJson() => {
//         "embeddable": embeddable,
//         "href": href,
//       };
// }

// class Cury {
//   Cury({
//     this.name,
//     this.href,
//     this.templated,
//   });

//   String name;
//   String href;
//   bool templated;

//   factory Cury.fromJson(Map<String, dynamic> json) => Cury(
//         name: json["name"],
//         href: json["href"],
//         templated: json["templated"],
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "href": href,
//         "templated": templated,
//       };
// }

// class PredecessorVersion {
//   PredecessorVersion({
//     this.id,
//     this.href,
//   });

//   int id;
//   String href;

//   factory PredecessorVersion.fromJson(Map<String, dynamic> json) =>
//       PredecessorVersion(
//         id: json["id"],
//         href: json["href"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "href": href,
//       };
// }

// class VersionHistory {
//   VersionHistory({
//     this.count,
//     this.href,
//   });

//   int count;
//   String href;

//   factory VersionHistory.fromJson(Map<String, dynamic> json) => VersionHistory(
//         count: json["count"],
//         href: json["href"],
//       );

//   Map<String, dynamic> toJson() => {
//         "count": count,
//         "href": href,
//       };
// }

// class WpTerm {
//   WpTerm({
//     this.taxonomy,
//     this.embeddable,
//     this.href,
//   });

//   Taxonomy taxonomy;
//   bool embeddable;
//   String href;

//   factory WpTerm.fromJson(Map<String, dynamic> json) => WpTerm(
//         taxonomy: taxonomyValues.map[json["taxonomy"]],
//         embeddable: json["embeddable"],
//         href: json["href"],
//       );

//   Map<String, dynamic> toJson() => {
//         "taxonomy": taxonomyValues.reverse[taxonomy],
//         "embeddable": embeddable,
//         "href": href,
//       };
// }

// enum Taxonomy { CATEGORY, POST_TAG }

// final taxonomyValues =
//     EnumValues({"category": Taxonomy.CATEGORY, "post_tag": Taxonomy.POST_TAG});

// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }

// To parse this JSON data, do
//
//     final postList = postListFromJson(jsonString);

import 'dart:convert';

List<PostList> postListFromJson(String str) =>
    List<PostList>.from(json.decode(str).map((x) => PostList.fromJson(x)));

String postListToJson(List<PostList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostList {
  PostList({
    // this.id,
    this.heading,
    this.description,
    this.image,
    this.youtubeurl,
  });

  // Id id;
  String heading;
  String description;
  String image;
  String youtubeurl;

  factory PostList.fromJson(Map<String, dynamic> json) => PostList(
        // id: Id.fromJson(json["_id"]),
        heading: json["Heading"],
        description: json["Description"],
        image: json["Image"],
        youtubeurl: json["youtubeurl"],
      );

  Map<String, dynamic> toJson() => {
        // "_id": id.toJson(),
        "Heading": heading,
        "Description": description,
        "Image": image,
        "youtubeurl": youtubeurl,
      };
}

// class Id {
//   Id({
//     this.oid,
//   });

//   String oid;

//   factory Id.fromJson(Map<String, dynamic> json) => Id(
//         oid: json["\u0024oid"],
//       );

//   Map<String, dynamic> toJson() => {
//         "\u0024oid": oid,
//       };
// }
