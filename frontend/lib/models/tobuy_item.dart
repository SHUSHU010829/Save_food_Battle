class ToBuyItem {
  late String string;
  late bool done;

  ToBuyItem(this.string) {
    done = false;
  }

  ToBuyItem.fromMap(Map map)
      : string = map['string'],
        done = map['done'];

  Map toMap() {
    return {'string': string, 'done': done};
  }
}
