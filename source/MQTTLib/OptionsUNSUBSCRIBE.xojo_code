#tag Class
Protected Class OptionsUNSUBSCRIBE
Implements ControlPacketOptions
	#tag Method, Flags = &h0
		Sub AddTopicName(inTopicName As String)
		  Self.pTopicNames.Append inTopicName
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetFixedHeaderFlagBits() As UInt8
		  Return &b0010
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetRawData() As String
		  
		  Dim theParts() As String
		  
		  // --- The variable header ---
		  
		  theParts.Append MQTTLib.GetUInt16BinaryString( Self.PacketID )
		  
		  // --- The payload ---
		  
		  For Each Topic As String In pTopicNames
		    theParts.Append MQTTLib.GetMQTTRawString( Topic )
		    
		  Next
		  
		  // Return the joined parts
		  Return Join( theParts, "" )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ParseFixedHeaderFlagBits(inFlags As UInt8)
		  //-- Check if the flags are valid and raise an exception if they aren't.
		  
		  If inFlags <> &b0010 Then
		    Raise New MQTTLib.ProtocolException( CurrentMethodName, Self.kInvalidFlagBitsMessage, MQTTLib.Error.InvalidFixedHeaderFlags )
		    
		  Else
		    Return
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ParseRawData(inRawData As MemoryBlock)
		  
		  Dim theRawDataSize As Integer = inRawData.Size
		  Dim theReadCursor As Integer
		  
		  Do 
		    // Read the length of the topic
		    Dim theLength As Integer = inRawData.UInt16Value( theReadCursor )
		    theReadCursor = theReadCursor + 2
		    
		    // Read the topic string, sets its encoding and store it
		    pTopicNames.Append inRawData.StringValue( theReadCursor, theLength ).DefineEncoding( Encodings.UTF8 )
		    
		    // Update the cursor
		    theReadCursor = theReadCursor + theLength
		    
		  Loop Until theReadCursor >= theRawDataSize
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TopicName(inIndex As Integer) As String
		  //-- Return the inIndex-th topic (one based).
		  
		  Return Self.pTopicNames( inIndex - 1 )
		End Function
	#tag EndMethod


	#tag Note, Name = Licensing
		MIT License
		
		Copyright (c) 2017 Za'atar Digital
		
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
			  Return Self.pTopicNames.UBound + 1
			End Get
		#tag EndGetter
		Count As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		PacketID As UInt16
	#tag EndProperty

	#tag Property, Flags = &h21
		Private pTopicNames() As String
	#tag EndProperty


	#tag Constant, Name = kInvalidFlagBitsMessage, Type = String, Dynamic = False, Default = \"The flag bits for UNSUBSCRIBEpacket must be &b0010", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Count"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="PacketID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="UInt16"
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
