{**************************************************************************************************}
{                                                                                                  }
{ Project JEDI Code Library (JCL)                                                                  }
{                                                                                                  }
{ The contents of this file are subject to the Mozilla Public License Version 1.1 (the "License"); }
{ you may not use this file except in compliance with the License. You may obtain a copy of the    }
{ License at http://www.mozilla.org/MPL/                                                           }
{                                                                                                  }
{ Software distributed under the License is distributed on an "AS IS" basis, WITHOUT WARRANTY OF   }
{ ANY KIND, either express or implied. See the License for the specific language governing rights  }
{ and limitations under the License.                                                               }
{                                                                                                  }
{ The Original Code is BinaryTree.pas.                                                             }
{                                                                                                  }
{ The Initial Developer of the Original Code is Jean-Philippe BEMPEL aka RDM. Portions created by  }
{ Jean-Philippe BEMPEL are Copyright (C) Jean-Philippe BEMPEL (rdm_30 att yahoo dott com)          }
{ All rights reserved.                                                                             }
{                                                                                                  }
{ Contributors:                                                                                    }
{   Florent Ouchet (outchy)                                                                        }
{                                                                                                  }
{**************************************************************************************************}
{                                                                                                  }
{ The Delphi Container Library                                                                     }
{                                                                                                  }
{**************************************************************************************************}
{                                                                                                  }
{ Last modified: $Date::                                                                         $ }
{ Revision:      $Rev::                                                                          $ }
{ Author:        $Author::                                                                       $ }
{                                                                                                  }
{**************************************************************************************************}

unit JclBinaryTrees;

{$I jcl.inc}

interface

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  Classes,
  {$IFDEF SUPPORTS_GENERICS}
  {$IFDEF CLR}
  System.Collections.Generic,
  {$ENDIF CLR}
  {$ENDIF SUPPORTS_GENERICS}
  JclBase, JclAbstractContainers, JclAlgorithms, JclContainerIntf;
{$I containers\JclBinaryTrees.imp}
type
(*$JPPEXPANDMACRO JCLBINARYTREEINT(TJclIntfBinaryNode,TJclIntfBinaryTree,TJclIntfAbstractContainer,IJclIntfCollection,IJclIntfTree,IJclIntfIterator, IJclIntfEqualityComparer\, IJclIntfComparer\,,
    FCompare: TIntfCompare;,
    { IJclIntfComparer }
    function ItemsCompare(const A, B: IInterface): Integer;
    { IJclIntfEqualityComparer }
    function ItemsEqual(const A, B: IInterface): Boolean;
    function CreateEmptyContainer: TJclAbstractContainerBase; override;,
    property Compare: TIntfCompare read FCompare write FCompare;,ACompare: TIntfCompare,,const AInterface: IInterface,IInterface)*)

(*$JPPEXPANDMACRO JCLBINARYTREEINT(TJclAnsiStrBinaryNode,TJclAnsiStrBinaryTree,TJclAnsiStrAbstractCollection,IJclAnsiStrCollection,IJclAnsiStrTree,IJclAnsiStrIterator, IJclStrContainer\, IJclAnsiStrContainer\, IJclAnsiStrFlatContainer\, IJclAnsiStrEqualityComparer\, IJclAnsiStrComparer\,,
    FCompare: TAnsiStrCompare;,
    { IJclAnsiStrComparer }
    function ItemsCompare(const A, B: AnsiString): Integer;
    { IJclAnsiStrEqualityComparer }
    function ItemsEqual(const A, B: AnsiString): Boolean;
    function CreateEmptyContainer: TJclAbstractContainerBase; override;,
    property Compare: TAnsiStrCompare read FCompare write FCompare;,ACompare: TAnsiStrCompare, override;,const AString: AnsiString,AnsiString)*)

(*$JPPEXPANDMACRO JCLBINARYTREEINT(TJclWideStrBinaryNode,TJclWideStrBinaryTree,TJclWideStrAbstractCollection,IJclWideStrCollection,IJclWideStrTree,IJclWideStrIterator, IJclStrContainer\, IJclWideStrContainer\, IJclWideStrFlatContainer\, IJclWideStrEqualityComparer\, IJclWideStrComparer\,,
    FCompare: TWideStrCompare;,
    { IJclWideStrComparer }
    function ItemsCompare(const A, B: WideString): Integer;
    { IJclWideStrEqualityComparer }
    function ItemsEqual(const A, B: WideString): Boolean;
    function CreateEmptyContainer: TJclAbstractContainerBase; override;,
    property Compare: TWideStrCompare read FCompare write FCompare;,ACompare: TWideStrCompare, override;,const AString: WideString,WideString)*)

  {$IFDEF CONTAINER_ANSISTR}
  TJclStrBinaryTree = TJclAnsiStrBinaryTree;
  {$ENDIF CONTAINER_ANSISTR}
  {$IFDEF CONTAINER_WIDESTR}
  TJclStrBinaryTree = TJclWideStrBinaryTree;
  {$ENDIF CONTAINER_WIDESTR}

(*$JPPEXPANDMACRO JCLBINARYTREEINT(TJclBinaryNode,TJclBinaryTree,TJclAbstractContainer,IJclCollection,IJclTree,IJclIterator, IJclObjectOwner\, IJclEqualityComparer\, IJclComparer\,,
    FCompare: TCompare;,
    { IJclComparer }
    function ItemsCompare(A, B: TObject): Integer;
    { IJclEqualityComparer }
    function ItemsEqual(A, B: TObject): Boolean;
    function CreateEmptyContainer: TJclAbstractContainerBase; override;,
    property Compare: TCompare read FCompare write FCompare;,ACompare: TCompare; AOwnsObjects: Boolean,,AObject: TObject,TObject)*)

  {$IFDEF SUPPORTS_GENERICS}
(*$JPPEXPANDMACRO JCLBINARYTREEINT(TJclBinaryNode<T>,TJclBinaryTree<T>,TJclAbstractContainer<T>,IJclCollection<T>,IJclTree<T>,IJclIterator<T>, IJclItemOwner<T>\, IJclEqualityComparer<T>\, IJclComparer<T>\,,,,,AOwnsItems: Boolean,,const AItem: T,T)*)

  // E = External helper to compare items
  TJclBinaryTreeE<T> = class(TJclBinaryTree<T>, {$IFDEF THREADSAFE} IJclLockable, {$ENDIF THREADSAFE}
    IJclIntfCloneable, IJclCloneable, IJclContainer, IJclItemOwner<T>, IJclEqualityComparer<T>, IJclComparer<T>,
    IJclCollection<T>, IJclTree<T>)
  private
    FComparer: IComparer<T>;
  protected
    procedure AssignPropertiesTo(Dest: TJclAbstractContainerBase); override;
    function CreateEmptyContainer: TJclAbstractContainerBase; override;
    { IJclComparer<T> }
    function ItemsCompare(const A, B: T): Integer; override;
    { IJclEqualityComparer<T> }
    function ItemsEqual(const A, B: T): Boolean; override;
    { IJclIntfCloneable }
    function IJclIntfCloneable.Clone = IntfClone;
  public
    constructor Create(const AComparer: IComparer<T>; AOwnsItems: Boolean);
    property Comparer: IComparer<T> read FComparer write FComparer;
  end;

  // F = Function to compare items
  TJclBinaryTreeF<T> = class(TJclBinaryTree<T>, {$IFDEF THREADSAFE} IJclLockable, {$ENDIF THREADSAFE}
    IJclIntfCloneable, IJclCloneable, IJclContainer, IJclItemOwner<T>, IJclEqualityComparer<T>, IJclComparer<T>,
    IJclCollection<T>, IJclTree<T>)
  private
    FCompare: TCompare<T>;
  protected
    procedure AssignPropertiesTo(Dest: TJclAbstractContainerBase); override;
    function CreateEmptyContainer: TJclAbstractContainerBase; override;
    { IJclComparer<T> }
    function ItemsCompare(const A, B: T): Integer; override;
    { IJclEqualityComparer<T> }
    function ItemsEqual(const A, B: T): Boolean; override;
    { IJclIntfCloneable }
    function IJclIntfCloneable.Clone = IntfClone;
  public
    constructor Create(ACompare: TCompare<T>; AOwnsItems: Boolean);
    property Compare: TCompare<T> read FCompare write FCompare;
  end;

  // I = Items can compare themselves to an other
  TJclBinaryTreeI<T: IComparable<T>> = class(TJclBinaryTree<T>, {$IFDEF THREADSAFE} IJclLockable, {$ENDIF THREADSAFE}
    IJclIntfCloneable, IJclCloneable, IJclContainer, IJclItemOwner<T>, IJclEqualityComparer<T>, IJclComparer<T>,
    IJclCollection<T>, IJclTree<T>)
  protected
    function CreateEmptyContainer: TJclAbstractContainerBase; override;
    { IJclComparer<T> }
    function ItemsCompare(const A, B: T): Integer; override;
    { IJclEqualityComparer<T> }
    function ItemsEqual(const A, B: T): Boolean; override;
    { IJclIntfCloneable }
    function IJclIntfCloneable.Clone = IntfClone;
  end;
  {$ENDIF SUPPORTS_GENERICS}


{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$URL$';
    Revision: '$Revision$';
    Date: '$Date$';
    LogPath: 'JCL\source\common'
    );
{$ENDIF UNITVERSIONING}

implementation

uses
  SysUtils;

{$JPPEXPANDMACRO JCLBINARYTREEITR(TIntfItr,TPreOrderIntfItr,TInOrderIntfItr,TPostOrderIntfItr,IJclIntfIterator,IJclIntfCollection,IJclIntfEqualityComparer,TJclIntfBinaryNode,const AInterface: IInterface,IInterface,AInterface,nil,GetObject,SetObject,FreeObject)}
{$JPPEXPANDMACRO JCLBINARYTREEITR(TAnsiStrItr,TPreOrderAnsiStrItr,TInOrderAnsiStrItr,TPostOrderAnsiStrItr,IJclAnsiStrIterator,IJclAnsiStrCollection,IJclAnsiStrEqualityComparer,TJclAnsiStrBinaryNode,const AString: AnsiString,AnsiString,AString,'',GetString,SetString,FreeString)}
{$JPPEXPANDMACRO JCLBINARYTREEITR(TWideStrItr,TPreOrderWideStrItr,TInOrderWideStrItr,TPostOrderWideStrItr,IJclWideStrIterator,IJclWideStrCollection,IJclWideStrEqualityComparer,TJclWideStrBinaryNode,const AString: WideString,WideString,AString,'',GetString,SetString,FreeString)}
{$JPPEXPANDMACRO JCLBINARYTREEITR(TItr,TPreOrderItr,TInOrderItr,TPostOrderItr,IJclIterator,IJclCollection,IJclEqualityComparer,TJclBinaryNode,AObject: TObject,TObject,AObject,nil,GetObject,SetObject,FreeObject)}
{$IFDEF SUPPORTS_GENERICS}
{$JPPEXPANDMACRO JCLBINARYTREEITR(TItr<T>,TPreOrderItr<T>,TInOrderItr<T>,TPostOrderItr<T>,IJclIterator<T>,IJclCollection<T>,IJclEqualityComparer<T>,TJclBinaryNode<T>,const AItem: T,T,AItem,Default(T),GetItem,SetItem,FreeItem)}
{$ENDIF SUPPORTS_GENERICS}

{$JPPDEFINEMACRO ITEMSCOMPARE
function TJclIntfBinaryTree.ItemsCompare(const A, B: IInterface): Integer;
begin
  if Assigned(FCompare) then
    Result := FCompare(A, B)
  else
    Result := inherited ItemsCompare(A, B);
end;
}
{$JPPDEFINEMACRO ITEMSEQUAL
function TJclIntfBinaryTree.ItemsEqual(const A, B: IInterface): Boolean;
begin
  if Assigned(FCompare) then
    Result := FCompare(A, B) = 0
  else
    Result := inherited ItemsEqual(A, B);
end;
}
{$JPPDEFINEMACRO CREATEEMPTYCONTAINER
function TJclIntfBinaryTree.CreateEmptyContainer: TJclAbstractContainerBase;
begin
  Result := TJclIntfBinaryTree.Create(FCompare);
  AssignPropertiesTo(Result);
end;
}
(*$JPPEXPANDMACRO JCLBINARYTREEIMP(TJclIntfBinaryTree,TJclIntfBinaryNode,TPreOrderIntfItr,TInOrderIntfItr,TPostOrderIntfItr,IJclIntfCollection,IJclIntfIterator,ACompare: TIntfCompare,
  FCompare := ACompare;,,const AInterface: IInterface,AInterface,nil,FreeObject)*)
{$JPPUNDEFMACRO ITEMSCOMPARE}
{$JPPUNDEFMACRO ITEMSEQUAL}
{$JPPUNDEFMACRO CREATEEMPTYCONTAINER}

{$JPPDEFINEMACRO ITEMSCOMPARE
function TJclAnsiStrBinaryTree.ItemsCompare(const A, B: AnsiString): Integer;
begin
  if Assigned(FCompare) then
    Result := FCompare(A, B)
  else
    Result := inherited ItemsCompare(A, B);
end;
}
{$JPPDEFINEMACRO ITEMSEQUAL
function TJclAnsiStrBinaryTree.ItemsEqual(const A, B: AnsiString): Boolean;
begin
  if Assigned(FCompare) then
    Result := FCompare(A, B) = 0
  else
    Result := inherited ItemsEqual(A, B);
end;
}
{$JPPDEFINEMACRO CREATEEMPTYCONTAINER
function TJclAnsiStrBinaryTree.CreateEmptyContainer: TJclAbstractContainerBase;
begin
  Result := TJclAnsiStrBinaryTree.Create(FCompare);
  AssignPropertiesTo(Result);
end;
}
(*$JPPEXPANDMACRO JCLBINARYTREEIMP(TJclAnsiStrBinaryTree,TJclAnsiStrBinaryNode,TPreOrderAnsiStrItr,TInOrderAnsiStrItr,TPostOrderAnsiStrItr,IJclAnsiStrCollection,IJclAnsiStrIterator,ACompare: TAnsiStrCompare,
  FCompare := ACompare;,,const AString: AnsiString,AString,'',FreeString)*)
{$JPPUNDEFMACRO ITEMSCOMPARE}
{$JPPUNDEFMACRO ITEMSEQUAL}
{$JPPUNDEFMACRO CREATEEMPTYCONTAINER}

{$JPPDEFINEMACRO ITEMSCOMPARE
function TJclWideStrBinaryTree.ItemsCompare(const A, B: WideString): Integer;
begin
  if Assigned(FCompare) then
    Result := FCompare(A, B)
  else
    Result := inherited ItemsCompare(A, B);
end;
}
{$JPPDEFINEMACRO ITEMSEQUAL
function TJclWideStrBinaryTree.ItemsEqual(const A, B: WideString): Boolean;
begin
  if Assigned(FCompare) then
    Result := FCompare(A, B) = 0
  else
    Result := inherited ItemsEqual(A, B);
end;
}
{$JPPDEFINEMACRO CREATEEMPTYCONTAINER
function TJclWideStrBinaryTree.CreateEmptyContainer: TJclAbstractContainerBase;
begin
  Result := TJclWideStrBinaryTree.Create(FCompare);
  AssignPropertiesTo(Result);
end;
}
(*$JPPEXPANDMACRO JCLBINARYTREEIMP(TJclWideStrBinaryTree,TJclWideStrBinaryNode,TPreOrderWideStrItr,TInOrderWideStrItr,TPostOrderWideStrItr,IJclWideStrCollection,IJclWideStrIterator,ACompare: TWideStrCompare,
  FCompare := ACompare;,,const AString: WideString,AString,'',FreeString)*)
{$JPPUNDEFMACRO ITEMSCOMPARE}
{$JPPUNDEFMACRO ITEMSEQUAL}
{$JPPUNDEFMACRO CREATEEMPTYCONTAINER}

{$JPPDEFINEMACRO ITEMSCOMPARE
function TJclBinaryTree.ItemsCompare(A, B: TObject): Integer;
begin
  if Assigned(FCompare) then
    Result := FCompare(A, B)
  else
    Result := inherited ItemsCompare(A, B);
end;
}
{$JPPDEFINEMACRO ITEMSEQUAL
function TJclBinaryTree.ItemsEqual(A, B: TObject): Boolean;
begin
  if Assigned(FCompare) then
    Result := FCompare(A, B) = 0
  else
    Result := inherited ItemsEqual(A, B);
end;
}
{$JPPDEFINEMACRO CREATEEMPTYCONTAINER
function TJclBinaryTree.CreateEmptyContainer: TJclAbstractContainerBase;
begin
  Result := TJclBinaryTree.Create(FCompare, False);
  AssignPropertiesTo(Result);
end;
}
(*$JPPEXPANDMACRO JCLBINARYTREEIMP(TJclBinaryTree,TJclBinaryNode,TPreOrderItr,TInOrderItr,TPostOrderItr,IJclCollection,IJclIterator,ACompare: TCompare; AOwnsObjects: Boolean,
  FCompare := ACompare;,\, AOwnsObjects,AObject: TObject,AObject,nil,FreeObject)*)
{$JPPUNDEFMACRO ITEMSCOMPARE}
{$JPPUNDEFMACRO ITEMSEQUAL}
{$JPPUNDEFMACRO CREATEEMPTYCONTAINER}

{$IFDEF SUPPORTS_GENERICS}

{$JPPDEFINEMACRO ITEMSCOMPARE}
{$JPPDEFINEMACRO ITEMSEQUAL}
{$JPPDEFINEMACRO CREATEEMPTYCONTAINER}
(*$JPPEXPANDMACRO JCLBINARYTREEIMP(TJclBinaryTree<T>,TJclBinaryNode<T>,TPreOrderItr<T>,TInOrderItr<T>,TPostOrderItr<T>,IJclCollection<T>,IJclIterator<T>,AOwnsItems: Boolean,,\, AOwnsItems,const AItem: T,AItem,Default(T),FreeItem)*)
{$JPPUNDEFMACRO ITEMSCOMPARE}
{$JPPUNDEFMACRO ITEMSEQUAL}
{$JPPUNDEFMACRO CREATEEMPTYCONTAINER}

//=== { TJclBinaryTreeE<T> } =================================================

constructor TJclBinaryTreeE<T>.Create(const AComparer: IComparer<T>; AOwnsItems: Boolean);
begin
  inherited Create(AOwnsItems);
  FComparer := AComparer;
end;

procedure TJclBinaryTreeE<T>.AssignPropertiesTo(Dest: TJclAbstractContainerBase);
begin
  inherited AssignPropertiesTo(Dest);
  if Dest is TJclBinaryTreeE<T> then
    TJclBinaryTreeE<T>(Dest).FComparer := FComparer;
end;

function TJclBinaryTreeE<T>.CreateEmptyContainer: TJclAbstractContainerBase;
begin
  Result := TJclBinaryTreeE<T>.Create(Comparer, False);
  AssignPropertiesTo(Result);
end;

function TJclBinaryTreeE<T>.ItemsCompare(const A, B: T): Integer;
begin
  if Comparer = nil then
    raise EJclNoComparerError.Create;
  Result := Comparer.Compare(A, B);
end;

function TJclBinaryTreeE<T>.ItemsEqual(const A, B: T): Boolean;
begin
  if Comparer = nil then
    raise EJclNoComparerError.Create;
  Result := Comparer.Compare(A, B) = 0;
end;

//=== { TJclBinaryTreeF<T> } =================================================

constructor TJclBinaryTreeF<T>.Create(ACompare: TCompare<T>; AOwnsItems: Boolean);
begin
  inherited Create(AOwnsItems);
  FCompare := ACompare;
end;

procedure TJclBinaryTreeF<T>.AssignPropertiesTo(Dest: TJclAbstractContainerBase);
begin
  inherited AssignPropertiesTo(Dest);
  if Dest is TJclBinaryTreeF<T> then
    TJclBinaryTreeF<T>(Dest).FCompare := FCompare;
end;

function TJclBinaryTreeF<T>.CreateEmptyContainer: TJclAbstractContainerBase;
begin
  Result := TJclBinaryTreeF<T>.Create(Compare, False);
  AssignPropertiesTo(Result);
end;

function TJclBinaryTreeF<T>.ItemsCompare(const A, B: T): Integer;
begin
  if not Assigned(Compare) then
    raise EJclNoComparerError.Create;
  Result := Compare(A, B);
end;

function TJclBinaryTreeF<T>.ItemsEqual(const A, B: T): Boolean;
begin
  if not Assigned(Compare) then
    raise EJclNoComparerError.Create;
  Result := Compare(A, B) = 0;
end;

//=== { TJclBinaryTreeI<T> } =================================================

function TJclBinaryTreeI<T>.CreateEmptyContainer: TJclAbstractContainerBase;
begin
  Result := TJclBinaryTreeI<T>.Create(False);
  AssignPropertiesTo(Result);
end;

function TJclBinaryTreeI<T>.ItemsCompare(const A, B: T): Integer;
begin
  Result := A.CompareTo(B);
end;

function TJclBinaryTreeI<T>.ItemsEqual(const A, B: T): Boolean;
begin
  Result := A.CompareTo(B) = 0;
end;

{$ENDIF SUPPORTS_GENERICS}

{$IFDEF UNITVERSIONING}
initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}

end.

