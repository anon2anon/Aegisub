-- Copyright (c) 2013, Thomas Goyne <plorkyeran@aegisub.org>
--
-- Permission to use, copy, modify, and distribute this software for any
-- purpose with or without fee is hereby granted, provided that the above
-- copyright notice and this permission notice appear in all copies.
--
-- THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
-- WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
-- MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
-- ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
-- WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
-- ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
-- OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

unicode = require 'aegisub.unicode'

describe 'charwidth', ->
  it 'should return 1 for an ascii character', ->
    assert.is.equal 1, unicode.charwidth 'a'
  it 'should return 2 for a two byte character', ->
    assert.is.equal 2, unicode.charwidth 'Ć'
  it 'should return 3 for a three byte character', ->
    assert.is.equal 3, unicode.charwidth 'ļ½'
  it 'should return 4 for a four byte character', ->
    assert.is.equal 4, unicode.charwidth 'š'

describe 'char_iterator', ->
  it 'should iterator over multi-byte codepoints', ->
    chars = [c for c in unicode.chars 'aĆļ½š']
    assert.is.equal 4, #chars
    assert.is.equal chars[1], 'a'
    assert.is.equal chars[2], 'Ć'
    assert.is.equal chars[3], 'ļ½'
    assert.is.equal chars[4], 'š'

describe 'len', ->
  it 'should give length in codepoints', ->
    assert.is.equal 4, unicode.len 'aĆļ½š'

describe 'codepoint', ->
  it 'should give codepoint as an integer for a string', ->
    assert.is.equal 97, unicode.codepoint 'a'
    assert.is.equal 223, unicode.codepoint 'Ć'
    assert.is.equal 0xFF43, unicode.codepoint 'ļ½'
    assert.is.equal 0x1F113, unicode.codepoint 'š'
  it 'should give ignore codepoints after the first', ->
    assert.is.equal 97, unicode.codepoint 'abc'

describe 'to_upper_case', ->
  it 'should support plain ASCII', ->
    assert.is.equal 'ABC', unicode.to_upper_case 'abc'
  it 'should support accents', ->
    assert.is.equal 'ĆĆĆ', unicode.to_upper_case 'Ć ĆØĆ¬'
  it 'should support fullwidth letters', ->
    assert.is.equal 'ļ¼”ļ¼¢ļ¼£', unicode.to_upper_case 'ļ½ļ½ļ½'
  it 'should support greek', ->
    assert.is.equal 'ĪĪĪ', unicode.to_upper_case 'Ī±Ī²Ī³'
  it 'should support sharp-s', ->
    assert.is.equal 'SS', unicode.to_upper_case 'Ć'
  it 'should support ligatures', ->
    assert.is.equal 'FFI', unicode.to_upper_case 'ļ¬'

describe 'to_lower_case', ->
  it 'should support plain ASCII', ->
    assert.is.equal 'abc', unicode.to_lower_case 'ABC'
  it 'should support accents', ->
    assert.is.equal 'Ć ĆØĆ¬', unicode.to_lower_case 'ĆĆĆ'
  it 'should support fullwidth letters', ->
    assert.is.equal 'ļ½ļ½ļ½', unicode.to_lower_case 'ļ¼”ļ¼¢ļ¼£'
  it 'should support greek', ->
    assert.is.equal 'Ī±Ī²Ī³', unicode.to_lower_case 'ĪĪĪ'
  it 'should support sharp-s', ->
    assert.is.equal 'Ć', unicode.to_lower_case 'įŗ'
  -- note: Unicode doesn't have any uppercase precomposed ligatures

describe 'to_fold_case', ->
  it 'should support plain ASCII', ->
    assert.is.equal 'abc', unicode.to_fold_case 'ABC'
  it 'should support accents', ->
    assert.is.equal 'Ć ĆØĆ¬', unicode.to_fold_case 'ĆĆĆ'
  it 'should support fullwidth letters', ->
    assert.is.equal 'ļ½ļ½ļ½', unicode.to_fold_case 'ļ¼”ļ¼¢ļ¼£'
  it 'should support greek', ->
    assert.is.equal 'Ī±Ī²Ī³', unicode.to_fold_case 'ĪĪĪ'
  it 'should support sharp-s', ->
    assert.is.equal 'ss', unicode.to_fold_case 'įŗ'
  it 'should support ligatures', ->
    assert.is.equal 'ffi', unicode.to_fold_case 'ļ¬'

