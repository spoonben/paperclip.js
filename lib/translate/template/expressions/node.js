// Generated by CoffeeScript 1.6.2
var NodeExpression,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

NodeExpression = (function(_super) {
  __extends(NodeExpression, _super);

  NodeExpression.prototype._type = "node";

  /*
  */


  function NodeExpression(name, attributes, children) {
    this.name = name;
    this.attributes = attributes;
    this.children = children;
    NodeExpression.__super__.constructor.call(this);
    if (attributes) {
      this.addChild(this.attributes);
    }
    if (children) {
      this.addChild(this.children);
    }
  }

  /*
  */


  NodeExpression.prototype.toJsString = function() {
    var buffer, options;

    buffer = ["').nodeBinding('" + this.name + "'"];
    options = [];
    if (this.attributes) {
      options.push(" attrs: " + (this.attributes.toJsString()) + " ");
    }
    if (this.children) {
      options.push(" children: paper.create().html('" + (this.children.toString()) + "') ");
    }
    if (options.length) {
      buffer.push(", {" + options + "}");
    }
    buffer.push(").html('");
    return buffer.join("");
  };

  /*
  */


  NodeExpression.prototype.toString = function() {
    var buffer, _ref;

    if ((_ref = this.attributes) != null ? _ref.hasBinding() : void 0) {
      return this.toJsString();
    }
    buffer = ["<" + this.name];
    if (this.attributes) {
      buffer.push(" ", this.attributes);
    }
    if (this.children) {
      buffer.push(">");
      buffer.push(this.children.items.join(""));
      buffer.push("</" + this.name + ">");
    } else {
      buffer.push("/>");
    }
    return buffer.join("");
  };

  return NodeExpression;

})(require("./base"));

module.exports = NodeExpression;