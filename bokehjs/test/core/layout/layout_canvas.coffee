_ = require "underscore"
{expect} = require "chai"
utils = require "../../utils"

LayoutCanvas = utils.require("core/layout/layout_canvas").Model
{Strength, Variable}  = utils.require "core/layout/solver"

describe "LayoutCanvas.Model", ->

  it "should should return no constraints", ->
    c = new LayoutCanvas()
    expect(c.get_constraints().length).to.be.equal 0

  it "should get new variables on doc_attached", ->
    c = new LayoutCanvas()
    expect(_.has(c, '_top')).to.be.false
    expect(_.has(c, '_left')).to.be.false
    expect(_.has(c, '_width')).to.be.false
    expect(_.has(c, '_height')).to.be.false
    c._doc_attached()
    expect(_.has(c, '_top')).to.be.true
    expect(_.has(c, '_left')).to.be.true
    expect(_.has(c, '_width')).to.be.true
    expect(_.has(c, '_height')).to.be.true
    expect(c._top).to.be.an.instanceOf(Variable)
    expect(c._left).to.be.an.instanceOf(Variable)
    expect(c._width).to.be.an.instanceOf(Variable)
    expect(c._height).to.be.an.instanceOf(Variable)

  it "should should return four strong edit variables", ->
    c = new LayoutCanvas()
    c._doc_attached()  # Need to run this so variables actually exist
    ev = c.get_edit_variables()
    expect(ev.length).to.be.equal 4
    variables = []
    for e in ev
      variables.push(e.edit_variable._name)
      expect(e.strength._strength).to.be.equal Strength.strong._strength
    expect(_.contains(variables, 'top')).to.be.true
    expect(_.contains(variables, 'left')).to.be.true
    expect(_.contains(variables, 'width')).to.be.true
    expect(_.contains(variables, 'height')).to.be.true

