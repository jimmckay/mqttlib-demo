#tag Class
Protected Class Queue
	#tag Method, Flags = &h0
		Sub ClearAll()
		  //-- Remove all the items in the queue
		  
		  #pragma DisableBackgroundTasks
		  
		  // Not the fastest but the simplest
		  Do Until IsEmpty
		    Call Dequeue
		    
		  Loop
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(inMaxSize As Integer = 0)
		  Self.pMaxSize = inMaxSize
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Dequeue() As zd.Utils.DataStructures.PushableItem
		  //-- Return the oldest item in the queue
		  
		  // Checking for error
		  If Self.pLastItem Is Nil Then
		    Raise New EmptyDataStructureException( CurrentMethodName, "Can't dequeue an empty queue.")
		    
		  End If
		  
		  // Unhook the outgoing item and hook up the item next to it
		  Dim theItem As zd.Utils.DataStructures.PushableItem = Self.pLastItem
		  Self.pFirstItem = theItem.GetNextItem
		  
		  // If the queue is now empty, Nil the last item's hook
		  If theItem.GetNextItem Is Nil Then Self.pLastItem = Nil
		  
		  // Decrement the items count
		  Self.pSize = Self.pSize - 1
		  
		  // Broke the link to its next item to avoid potential memory leaks
		  theItem.SetNextItem( Nil )
		  
		  // Return the outgoing item
		  Return theItem
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Enqueue(inNewItem AS zd.Utils.DataStructures.PushableItem)
		  //-- Put a new item in the queue
		  
		  // Checking for errors
		  If inNewItem Is Nil Then
		    Raise New zd.Utils.DataStructures.NilPushableItemException( CurrentMethodName, "Can't enqueue a Nil item." )
		    
		  End If
		  
		  If Self.pMaxSize > 0 And Self.pSize = Self.pMaxSize Then
		    Raise New zd.Utils.DataStructures.FullDataStructureException( CurrentMethodName, "This queue is full (max size is " + Str( Self.pMaxSize ) + ")." )
		    
		  End If
		  
		  // Is there any other item in the queue?
		  If Self.pFirstItem Is Nil Then
		    // No other item, so this is the next to go out.
		    Self.pFirstItem = inNewItem
		    
		  Else
		    // Hook up the new item to the last one in the queue
		    Self.pLastItem.SetNextItem( inNewItem )
		    
		  End If
		  
		  // Set the new item as the last item
		  Self.pLastItem = inNewItem
		  
		  // Increment the count of items
		  Self.pSize = Self.pSize + 1
		End Sub
	#tag EndMethod


	#tag Note, Name = Licensing
		MIT License
		
		Copyright (c) 2012-2017 Za'atar Digital
		
		Permission is hereby granted, free of charge, to any person obtaining a copy
		of this software and associated documentation files (the "Software"), to deal
		in the Software without restriction, including without limitation the rights
		to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
		copies of the Software, and to permit persons to whom the Software is
		furnished to do so, subject to the following conditions:
		
		The above copyright notice and this permission notice shall be included in all
		copies or substantial portions of the Software.
		
		THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
		IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
		FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
		AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
		LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
		OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
		SOFTWARE.
		
	#tag EndNote


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  //-- True if the queue has no item
			  // This property is read only
			  
			  Return Self.pLastItem Is Nil
			End Get
		#tag EndGetter
		IsEmpty As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  //-- Return the maximum size for this queue
			  
			  Return Self.pMaxSize
			End Get
		#tag EndGetter
		MaxSize As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private pFirstItem As zd.Utils.DataStructures.PushableItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private pLastItem As zd.Utils.DataStructures.PushableItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private pMaxSize As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private pSize As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  //-- The number of items in the queue
			  // This property is read only
			  
			  Return Self.pSize
			End Get
		#tag EndGetter
		Size As Integer
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsEmpty"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MaxSize"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Size"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
