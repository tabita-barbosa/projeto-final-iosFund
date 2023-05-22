//
//  Extensions.swift
//  trabalho-final
//
//  Created by Tabita Barbosa on 21/05/23.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
   public subscript(safe index: Index) -> Iterator.Element? {
     return (startIndex <= index && index < endIndex) ? self[index] : nil
   }
}
