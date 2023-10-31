class Blog {

  String image_url = "";
  String title = "";

  Blog({ required this.image_url, required this.title});

  Blog.fromJson(Map<String, dynamic> json) {
    image_url = json['image_url'];
    title = json['title'];

  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image_url'] = image_url;
    data['title'] = title;

    return data;
  }


}

