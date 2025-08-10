#if canImport(SharingMacros)
  import MacroTesting
  import SharingMacros
  import SnapshotTesting
  import SwiftSyntaxMacros
  import SwiftSyntaxMacrosTestSupport
  import XCTest

  final class ObservableValueMacroTests: MacroBaseTestCase {
    override func invokeTest() {
      withSnapshotTesting(record: .failed) {
        withMacroTesting {
          super.invokeTest()
        }
      }
    }

    func testAvailability() {
      assertMacro {
        """
        @ObservableValue
        @available(iOS 18, *)
        struct State {
          var count = 0
        }
        """
      } expansion: {
        #"""
        @available(iOS 18, *)
        struct State {
          var count {
            @storageRestrictions(initializes: _count)
            init(initialValue) {
              _count = initialValue
            }
            get {
              _$observationRegistrar.access(self, keyPath: \.count)
              return _count
            }
            set {
              guard shouldNotifyObservers(_count, newValue) else {
                return
              }
              _$observationRegistrar.mutate(self, keyPath: \.count, &_count, newValue, _$sharing_isIdentityEqual)
            }
            _modify {
              let oldValue = _$observationRegistrar.willModify(self, keyPath: \.count, &_count)
              yield &_count
              guard shouldNotifyObservers(oldValue, count) else {
                return
              }
              _$observationRegistrar.didModify(self, keyPath: \.count, &_count, oldValue, _$sharing_isIdentityEqual)
            }
          }

          var _$observationRegistrar = Sharing.ObservationValueRegistrar()

          public var _$id: Sharing.ObservableValueID {
            _$observationRegistrar.id
          }

          public mutating func _$willModify() {
            _$observationRegistrar._$willModify()
          }

          private nonisolated func shouldNotifyObservers<__macro_local_6MemberfMu_>(_ lhs: __macro_local_6MemberfMu_, _ rhs: __macro_local_6MemberfMu_) -> Bool {
            true
          }

          private nonisolated func shouldNotifyObservers<__macro_local_6MemberfMu0_: Equatable>(_ lhs: __macro_local_6MemberfMu0_, _ rhs: __macro_local_6MemberfMu0_) -> Bool {
            lhs != rhs
          }

          private nonisolated func shouldNotifyObservers<__macro_local_6MemberfMu1_: AnyObject>(_ lhs: __macro_local_6MemberfMu1_, _ rhs: __macro_local_6MemberfMu1_) -> Bool {
            lhs !== rhs
          }

          private nonisolated func shouldNotifyObservers<__macro_local_6MemberfMu2_: Equatable & AnyObject>(_ lhs: __macro_local_6MemberfMu2_, _ rhs: __macro_local_6MemberfMu2_) -> Bool {
            lhs != rhs
          }
        }
        """#
      }
    }

    func testObservableValue() throws {
      assertMacro {
        #"""
        @ObservableValue
        struct State {
          var count = 0
        }
        """#
      } expansion: {
        #"""
        struct State {
          var count {
            @storageRestrictions(initializes: _count)
            init(initialValue) {
              _count = initialValue
            }
            get {
              _$observationRegistrar.access(self, keyPath: \.count)
              return _count
            }
            set {
              guard shouldNotifyObservers(_count, newValue) else {
                return
              }
              _$observationRegistrar.mutate(self, keyPath: \.count, &_count, newValue, _$sharing_isIdentityEqual)
            }
            _modify {
              let oldValue = _$observationRegistrar.willModify(self, keyPath: \.count, &_count)
              yield &_count
              guard shouldNotifyObservers(oldValue, count) else {
                return
              }
              _$observationRegistrar.didModify(self, keyPath: \.count, &_count, oldValue, _$sharing_isIdentityEqual)
            }
          }

          var _$observationRegistrar = Sharing.ObservationValueRegistrar()

          public var _$id: Sharing.ObservableValueID {
            _$observationRegistrar.id
          }

          public mutating func _$willModify() {
            _$observationRegistrar._$willModify()
          }

          private nonisolated func shouldNotifyObservers<__macro_local_6MemberfMu_>(_ lhs: __macro_local_6MemberfMu_, _ rhs: __macro_local_6MemberfMu_) -> Bool {
            true
          }

          private nonisolated func shouldNotifyObservers<__macro_local_6MemberfMu0_: Equatable>(_ lhs: __macro_local_6MemberfMu0_, _ rhs: __macro_local_6MemberfMu0_) -> Bool {
            lhs != rhs
          }

          private nonisolated func shouldNotifyObservers<__macro_local_6MemberfMu1_: AnyObject>(_ lhs: __macro_local_6MemberfMu1_, _ rhs: __macro_local_6MemberfMu1_) -> Bool {
            lhs !== rhs
          }

          private nonisolated func shouldNotifyObservers<__macro_local_6MemberfMu2_: Equatable & AnyObject>(_ lhs: __macro_local_6MemberfMu2_, _ rhs: __macro_local_6MemberfMu2_) -> Bool {
            lhs != rhs
          }
        }
        """#
      }
    }

    func testObservableValue_AccessControl() throws {
      assertMacro {
        #"""
        @ObservableValue
        public struct State {
          var count = 0
        }
        """#
      } expansion: {
        #"""
        public struct State {
          var count {
            @storageRestrictions(initializes: _count)
            init(initialValue) {
              _count = initialValue
            }
            get {
              _$observationRegistrar.access(self, keyPath: \.count)
              return _count
            }
            set {
              guard shouldNotifyObservers(_count, newValue) else {
                return
              }
              _$observationRegistrar.mutate(self, keyPath: \.count, &_count, newValue, _$sharing_isIdentityEqual)
            }
            _modify {
              let oldValue = _$observationRegistrar.willModify(self, keyPath: \.count, &_count)
              yield &_count
              guard shouldNotifyObservers(oldValue, count) else {
                return
              }
              _$observationRegistrar.didModify(self, keyPath: \.count, &_count, oldValue, _$sharing_isIdentityEqual)
            }
          }

          var _$observationRegistrar = Sharing.ObservationValueRegistrar()

          public var _$id: Sharing.ObservableValueID {
            _$observationRegistrar.id
          }

          public mutating func _$willModify() {
            _$observationRegistrar._$willModify()
          }

          private nonisolated func shouldNotifyObservers<__macro_local_6MemberfMu_>(_ lhs: __macro_local_6MemberfMu_, _ rhs: __macro_local_6MemberfMu_) -> Bool {
            true
          }

          private nonisolated func shouldNotifyObservers<__macro_local_6MemberfMu0_: Equatable>(_ lhs: __macro_local_6MemberfMu0_, _ rhs: __macro_local_6MemberfMu0_) -> Bool {
            lhs != rhs
          }

          private nonisolated func shouldNotifyObservers<__macro_local_6MemberfMu1_: AnyObject>(_ lhs: __macro_local_6MemberfMu1_, _ rhs: __macro_local_6MemberfMu1_) -> Bool {
            lhs !== rhs
          }

          private nonisolated func shouldNotifyObservers<__macro_local_6MemberfMu2_: Equatable & AnyObject>(_ lhs: __macro_local_6MemberfMu2_, _ rhs: __macro_local_6MemberfMu2_) -> Bool {
            lhs != rhs
          }
        }
        """#
      }
      assertMacro {
        #"""
        @ObservableValue
        package struct State {
          var count = 0
        }
        """#
      } expansion: {
        #"""
        package struct State {
          var count {
            @storageRestrictions(initializes: _count)
            init(initialValue) {
              _count = initialValue
            }
            get {
              _$observationRegistrar.access(self, keyPath: \.count)
              return _count
            }
            set {
              guard shouldNotifyObservers(_count, newValue) else {
                return
              }
              _$observationRegistrar.mutate(self, keyPath: \.count, &_count, newValue, _$sharing_isIdentityEqual)
            }
            _modify {
              let oldValue = _$observationRegistrar.willModify(self, keyPath: \.count, &_count)
              yield &_count
              guard shouldNotifyObservers(oldValue, count) else {
                return
              }
              _$observationRegistrar.didModify(self, keyPath: \.count, &_count, oldValue, _$sharing_isIdentityEqual)
            }
          }

          var _$observationRegistrar = Sharing.ObservationValueRegistrar()

          public var _$id: Sharing.ObservableValueID {
            _$observationRegistrar.id
          }

          public mutating func _$willModify() {
            _$observationRegistrar._$willModify()
          }

          private nonisolated func shouldNotifyObservers<__macro_local_6MemberfMu_>(_ lhs: __macro_local_6MemberfMu_, _ rhs: __macro_local_6MemberfMu_) -> Bool {
            true
          }

          private nonisolated func shouldNotifyObservers<__macro_local_6MemberfMu0_: Equatable>(_ lhs: __macro_local_6MemberfMu0_, _ rhs: __macro_local_6MemberfMu0_) -> Bool {
            lhs != rhs
          }

          private nonisolated func shouldNotifyObservers<__macro_local_6MemberfMu1_: AnyObject>(_ lhs: __macro_local_6MemberfMu1_, _ rhs: __macro_local_6MemberfMu1_) -> Bool {
            lhs !== rhs
          }

          private nonisolated func shouldNotifyObservers<__macro_local_6MemberfMu2_: Equatable & AnyObject>(_ lhs: __macro_local_6MemberfMu2_, _ rhs: __macro_local_6MemberfMu2_) -> Bool {
            lhs != rhs
          }
        }
        """#
      }
    }

    func testObservableValueIgnored() throws {
      assertMacro {
        #"""
        @ObservableValue
        struct State {
          @ObservationValueIgnored
          var count = 0
        }
        """#
      } expansion: {
        """
        struct State {
          var count = 0

          var _$observationRegistrar = Sharing.ObservationValueRegistrar()

          public var _$id: Sharing.ObservableValueID {
            _$observationRegistrar.id
          }

          public mutating func _$willModify() {
            _$observationRegistrar._$willModify()
          }

          private nonisolated func shouldNotifyObservers<__macro_local_6MemberfMu_>(_ lhs: __macro_local_6MemberfMu_, _ rhs: __macro_local_6MemberfMu_) -> Bool {
            true
          }

          private nonisolated func shouldNotifyObservers<__macro_local_6MemberfMu0_: Equatable>(_ lhs: __macro_local_6MemberfMu0_, _ rhs: __macro_local_6MemberfMu0_) -> Bool {
            lhs != rhs
          }

          private nonisolated func shouldNotifyObservers<__macro_local_6MemberfMu1_: AnyObject>(_ lhs: __macro_local_6MemberfMu1_, _ rhs: __macro_local_6MemberfMu1_) -> Bool {
            lhs !== rhs
          }

          private nonisolated func shouldNotifyObservers<__macro_local_6MemberfMu2_: Equatable & AnyObject>(_ lhs: __macro_local_6MemberfMu2_, _ rhs: __macro_local_6MemberfMu2_) -> Bool {
            lhs != rhs
          }
        }
        """
      }
    }

    func testObservableValue_Enum() {
      assertMacro {
        """
        @ObservableValue
        enum Path {
          case feature1(Feature1.State)
          case feature2(Feature2.State)
        }
        """
      } expansion: {
        """
        enum Path {
          case feature1(Feature1.State)
          case feature2(Feature2.State)

          public var _$id: Sharing.ObservableValueID {
            switch self {
            case let .feature1(state):
              return ._$id(for: state)._$tag(0)
            case let .feature2(state):
              return ._$id(for: state)._$tag(1)
            }
          }

          public mutating func _$willModify() {
            switch self {
            case var .feature1(state):
              Sharing._$willModify(&state)
              self = .feature1(state)
            case var .feature2(state):
              Sharing._$willModify(&state)
              self = .feature2(state)
            }
          }
        }
        """
      }
    }

    func testObservableValue_Enum_Label() {
      assertMacro {
        """
        @ObservableValue
        enum Path {
          case feature1(state: String)
        }
        """
      } expansion: {
        """
        enum Path {
          case feature1(state: String)

          public var _$id: Sharing.ObservableValueID {
            switch self {
            case let .feature1(state):
              return ._$id(for: state)._$tag(0)
            }
          }

          public mutating func _$willModify() {
            switch self {
            case var .feature1(state):
              Sharing._$willModify(&state)
              self = .feature1(state: state)
            }
          }
        }
        """
      }
    }

    func testObservableValue_Enum_AccessControl() {
      assertMacro {
        """
        @ObservableValue
        public enum Path {
          case feature1(Feature1.State)
          case feature2(Feature2.State)
        }
        """
      } expansion: {
        """
        public enum Path {
          case feature1(Feature1.State)
          case feature2(Feature2.State)

          public var _$id: Sharing.ObservableValueID {
            switch self {
            case let .feature1(state):
              return ._$id(for: state)._$tag(0)
            case let .feature2(state):
              return ._$id(for: state)._$tag(1)
            }
          }

          public mutating func _$willModify() {
            switch self {
            case var .feature1(state):
              Sharing._$willModify(&state)
              self = .feature1(state)
            case var .feature2(state):
              Sharing._$willModify(&state)
              self = .feature2(state)
            }
          }
        }
        """
      }
      assertMacro {
        """
        @ObservableValue
        package enum Path {
          case feature1(Feature1.State)
          case feature2(Feature2.State)
        }
        """
      } expansion: {
        """
        package enum Path {
          case feature1(Feature1.State)
          case feature2(Feature2.State)

          public var _$id: Sharing.ObservableValueID {
            switch self {
            case let .feature1(state):
              return ._$id(for: state)._$tag(0)
            case let .feature2(state):
              return ._$id(for: state)._$tag(1)
            }
          }

          public mutating func _$willModify() {
            switch self {
            case var .feature1(state):
              Sharing._$willModify(&state)
              self = .feature1(state)
            case var .feature2(state):
              Sharing._$willModify(&state)
              self = .feature2(state)
            }
          }
        }
        """
      }
    }

    func testObservableValue_Enum_AccessControl_WrappedByExtension() {
      assertMacro {
        """
        public extension Feature {
          @ObservableValue
          enum Path {
            case feature1(Feature1.State)
            case feature2(Feature2.State)
          }
        }
        """
      } expansion: {
        """
        public extension Feature {
          enum Path {
            case feature1(Feature1.State)
            case feature2(Feature2.State)

            public var _$id: Sharing.ObservableValueID {
              switch self {
              case let .feature1(state):
                return ._$id(for: state)._$tag(0)
              case let .feature2(state):
                return ._$id(for: state)._$tag(1)
              }
            }

            public mutating func _$willModify() {
              switch self {
              case var .feature1(state):
                Sharing._$willModify(&state)
                self = .feature1(state)
              case var .feature2(state):
                Sharing._$willModify(&state)
                self = .feature2(state)
              }
            }
          }
        }
        """
      }
      assertMacro {
        """
        public extension Feature {
          @ObservableValue
          package enum Path {
            case feature1(Feature1.State)
            case feature2(Feature2.State)
          }
        }
        """
      } expansion: {
        """
        public extension Feature {
          package enum Path {
            case feature1(Feature1.State)
            case feature2(Feature2.State)

            public var _$id: Sharing.ObservableValueID {
              switch self {
              case let .feature1(state):
                return ._$id(for: state)._$tag(0)
              case let .feature2(state):
                return ._$id(for: state)._$tag(1)
              }
            }

            public mutating func _$willModify() {
              switch self {
              case var .feature1(state):
                Sharing._$willModify(&state)
                self = .feature1(state)
              case var .feature2(state):
                Sharing._$willModify(&state)
                self = .feature2(state)
              }
            }
          }
        }
        """
      }
    }

    func testObservableValue_Enum_NonObservableCase() {
      assertMacro {
        """
        @ObservableValue
        public enum Path {
          case foo(Int)
        }
        """
      } expansion: {
        """
        public enum Path {
          case foo(Int)

          public var _$id: Sharing.ObservableValueID {
            switch self {
            case let .foo(state):
              return ._$id(for: state)._$tag(0)
            }
          }

          public mutating func _$willModify() {
            switch self {
            case var .foo(state):
              Sharing._$willModify(&state)
              self = .foo(state)
            }
          }
        }
        """
      }
    }

    func testObservableValue_Enum_MultipleAssociatedValues() {
      assertMacro {
        """
        @ObservableValue
        public enum Path {
          case foo(Int, String)
        }
        """
      } expansion: {
        """
        public enum Path {
          case foo(Int, String)

          public var _$id: Sharing.ObservableValueID {
            switch self {
            case .foo:
              return ObservableValueID()._$tag(0)
            }
          }

          public mutating func _$willModify() {
            switch self {
            case .foo:
              break
            }
          }
        }
        """
      }
    }

    func testObservableValue_Class() {
      assertMacro {
        """
        @ObservableValue
        public class Model {
        }
        """
      } diagnostics: {
        """
        @ObservableValue
        ┬───────────────
        ╰─ 🛑 '@ObservableValue' cannot be applied to class type 'Model'
        public class Model {
        }
        """
      } 
    }

    func testObservableValue_Actor() {
      assertMacro {
        """
        @ObservableValue
        public actor Model {
        }
        """
      } diagnostics: {
        """
        @ObservableValue
        ┬───────────────
        ╰─ 🛑 '@ObservableValue' cannot be applied to actor type 'Model'
        public actor Model {
        }
        """
      } 
    }

    func testObservableValue_Enum_IfConfig() {
      assertMacro {
        """
        @ObservableValue
        public enum State {
          case child(ChildFeature.State)
          #if os(macOS)
            case mac(MacFeature.State)
          #elseif os(tvOS)
            case tv(TVFeature.State)
          #endif

          #if DEBUG
            #if INNER
              case inner(InnerFeature.State)
            #endif
          #endif
        }
        """
      } expansion: {
        """
        public enum State {
          case child(ChildFeature.State)
          #if os(macOS)
            case mac(MacFeature.State)
          #elseif os(tvOS)
            case tv(TVFeature.State)
          #endif

          #if DEBUG
            #if INNER
              case inner(InnerFeature.State)
            #endif
          #endif

          public var _$id: Sharing.ObservableValueID {
            switch self {
            case let .child(state):
              return ._$id(for: state)._$tag(0)
            #if os(macOS)
            case let .mac(state):
              return ._$id(for: state)._$tag(1)
            #elseif os(tvOS)
            case let .tv(state):
              return ._$id(for: state)._$tag(2)
            #endif

            #if DEBUG
            #if INNER
            case let .inner(state):
              return ._$id(for: state)._$tag(3)
            #endif
            #endif

            }
          }

          public mutating func _$willModify() {
            switch self {
            case var .child(state):
              Sharing._$willModify(&state)
              self = .child(state)
            #if os(macOS)
            case var .mac(state):
              Sharing._$willModify(&state)
              self = .mac(state)
            #elseif os(tvOS)
            case var .tv(state):
              Sharing._$willModify(&state)
              self = .tv(state)
            #endif

            #if DEBUG
            #if INNER
            case var .inner(state):
              Sharing._$willModify(&state)
              self = .inner(state)
            #endif
            #endif

            }
          }
        }
        """
      }
    }

    func testKnownSupportedPropertyWrappers() {
      assertMacro {
        """
        @ObservableValue
        struct State {
          @Shared var shared: Int
          @SharedReader var sharedReader: Int
          @Fetch var fetch: Int 
          @FetchAll var fetchAll: Int 
          @FetchOne var fetchOne: Int
        }
        """
      } expansion: {
        """
        struct State {
          @Shared
          var shared: Int
          @SharedReader
          var sharedReader: Int
          @Fetch
          var fetch: Int 
          @FetchAll
          var fetchAll: Int 
          @FetchOne
          var fetchOne: Int

          var _$observationRegistrar = Sharing.ObservationValueRegistrar()

          public var _$id: Sharing.ObservableValueID {
            _$observationRegistrar.id
          }

          public mutating func _$willModify() {
            _$observationRegistrar._$willModify()
          }

          private nonisolated func shouldNotifyObservers<__macro_local_6MemberfMu_>(_ lhs: __macro_local_6MemberfMu_, _ rhs: __macro_local_6MemberfMu_) -> Bool {
            true
          }

          private nonisolated func shouldNotifyObservers<__macro_local_6MemberfMu0_: Equatable>(_ lhs: __macro_local_6MemberfMu0_, _ rhs: __macro_local_6MemberfMu0_) -> Bool {
            lhs != rhs
          }

          private nonisolated func shouldNotifyObservers<__macro_local_6MemberfMu1_: AnyObject>(_ lhs: __macro_local_6MemberfMu1_, _ rhs: __macro_local_6MemberfMu1_) -> Bool {
            lhs !== rhs
          }

          private nonisolated func shouldNotifyObservers<__macro_local_6MemberfMu2_: Equatable & AnyObject>(_ lhs: __macro_local_6MemberfMu2_, _ rhs: __macro_local_6MemberfMu2_) -> Bool {
            lhs != rhs
          }
        }
        """
      }
    }
  }
#endif
