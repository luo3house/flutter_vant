class BEM {
  String? block;
  String? element;
  String? modifier;
  String? id;
  BEM([this.block, this.element, this.modifier, this.id]);
  BEM clone() => BEM(block, element, modifier, id);
  BEM b(String? b) => this..block = b;
  BEM e(String? e) => this..element = e;
  BEM m(String? m) => this..modifier = m;
  BEM i(String? i) => this..id = i;
  @override
  String toString() {
    return [
      block ?? '',
      (element != null ? '_' : '') + (element ?? ''),
      (modifier != null ? '--' : '') + (modifier ?? ''),
      (id != null ? '@' : '') + (id ?? '')
    ].join("");
  }
}
